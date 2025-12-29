CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50) NOT NULL,
city VARCHAR(40),
registration_date DATE 
);

CREATE TABLE products (
product_id INT PRIMARY KEY,
product_name VARCHAR(40) NOT NULL,
category VARCHAR(40),
price INT CHECK (price>0)
);

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
product_id INT,
order_date DATE,
quantity INT CHECK (quantity >0),

CONSTRAINT fk_customer
   FOREIGN KEY (customer_id)
   REFERENCES customers(customer_id),

CONSTRAINT fk_product
   FOREIGN KEY (product_id)
   REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'John Smith', 'New York', '2023-01-10'),
(2, 'Alice Brown', 'Chicago', '2023-02-15'),
(3, 'Michael Lee', 'Los Angeles', '2023-03-05');

INSERT INTO products VALUES 
(101, 'Laptop', 'Electronics', 800),
(102, 'Desk Chair', 'Furniture', 150),
(103, 'Smartphone', 'Electronics', 600);

INSERT INTO orders VALUES
(1001, 1, 101, '2023-04-01', 1),
(1002, 2, 102, '2023-04-02', 2),
(1003, 3, 103, '2023-04-05', 1);


SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

--Data processing using JOINS
SELECT o.order_id,
       c.customer_id,
	   p.product_name,
	   o.quantity,
	   p.price,
	   (o.quantity * p.price) AS total_amount
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

--Total spending per customer

SELECT c.customer_name,
       SUM(o.quantity * p.price) AS total_spending
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name;

--View for reporting

CREATE VIEW sales_summary AS 
SELECT c.customer_name,
       p.category,
       SUM(o.quantity * p.price) AS total_spending
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name, p.category;

SELECT * FROM sales_summary;

--ALL customers from customers table
SELECT * FROM customers;

--Names of all products in products table
SELECT product_name
FROM products;

--All orders made by customer_id =1
SELECT * FROM orders
WHERE customer_id = 1;

--adding some extra data to orders table 
INSERT INTO orders
VALUES
(1004, 1, 103, '2023-04-05', 1),
(1005, 3, 102, '2023-04-05', 1);

SELECT * FROM orders;

--Unique product category
SELECT DISTINCT (category) AS unique_category
FROM products;

--customers who lived in 'Chicago'
SELECT * FROM customers
WHERE city = 'Chicago';

--Show orders placed after ‘2023-04-02’
SELECT * FROM orders
WHERE order_date > '2023-04-02';

--product details for ProductID = 103. 
SELECT * FROM products
WHERE product_id = 103;

--total number of customers
SELECT COUNT(customer_id) AS total_customers
FROM customers;

--total number of products
SELECT COUNT(product_id) AS total_products
FROM products;

-- total quantity ordered in all orders. 
SELECT SUM(quantity) AS total_quantity
FROM orders;

--Sort all customers by RegistrationDate.
SELECT * FROM customers
ORDER BY registration_date DESC;

--all orders sorted by OrderDate (latest first).
SELECT * FROM orders
ORDER BY order_date DESC;

-- all products costing more than 500
SELECT * FROM products
WHERE price > 500;

-- customers who registered in 2023. 
SELECT * FROM customers
WHERE EXTRACT(YEAR FROM registration_date) = 2023;

--orders where quantity is greater than 1. 
SELECT * FROM orders
WHERE quantity > 1;

--Show customer name along with their order details (JOIN).
SELECT o.order_id,
       c.customer_name,
	   p.product_name,
	   o.quantity,
	   o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

--Show product name and total quantity sold for each product. 
SELECT p.product_name,
       SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o ON 
o.product_id = p.product_id
GROUP BY p.product_name;

--List customers who bought Electronics category products.
SELECT c.customer_name,
       p.category
FROM customers c
LEFT JOIN orders o ON
c.customer_id = o.customer_id
JOIN products p ON
o.product_id = p.product_id
WHERE p.category = 'Electronics';

-- Calculate the total revenue (Price × Quantity) for each order. 
SELECT p.product_name,
       ROUND(SUM(p.price * o.quantity),2) AS total_revenue
FROM products p 
JOIN orders o ON
p.product_id = o.product_id
GROUP BY p.product_name;

--Show total spending by each customer. 
SELECT c.customer_name,
       ROUND(SUM(p.price * o.quantity), 2) AS total_spending
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name;

--Count how many orders each customer has placed. 
SELECT c.customer_name,
       SUM(o.quantity) AS total_orders_placed
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

--Show best-selling product (highest total quantity). 
SELECT p.product_name,
       SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 1;

--Show number of orders for each product category. 
SELECT p.category,
       SUM(o.quantity) AS total_orders
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category;

--Show customers who have not placed any orders
SELECT c.*,
       o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

--Find the most expensive product. 
SELECT product_name, price
FROM products 
ORDER BY price DESC
LIMIT 1;

----Find the least expensive product. 
SELECT product_name, price
FROM products 
ORDER BY price
LIMIT 1;

-- Show orders placed between '2023-07-01' and '2023-07-10'.
SELECT * 
FROM orders
WHERE order_date BETWEEN '2023-07-01' AND '2023-07-10';

--List all orders along with product price and total bill amount.
SELECT o.order_id,
       p.price,
	   p.product_name,
	   o.quantity,
	   p.price * o.quantity AS total_bill
FROM orders o
JOIN products p ON o.product_id = p.product_id;

--Show products that were never ordered. 
SELECT product_name
FROM products
WHERE product_id NOT IN (
SELECT product_id
FROM orders
);

--Count how many customers registered city-wise
SELECT city, COUNT(customer_id) AS total_customer
FROM customers
GROUP BY city;

--Show customers who placed an order on the same date as CustomerID = 3
SELECT DISTINCT c.customer_name, o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date IN (SELECT order_date
FROM orders
WHERE customer_id = 3
AND c.customer_id <> 3);

--Retrieve customers who bought the most expensive product.
SELECT c.customer_name,
       p.product_name,
	   p.price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE p.price = (SELECT MAX(price)
FROM products);

-- List customers who have placed more orders than the average number of orders per customer
SELECT c.customer_name,
       COUNT(o.order_id) AS order_placed
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > (SELECT AVG(order_count)
FROM (SELECT COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id) AS t);

-- Find products whose price is higher than every product in Accessories category
SELECT product_name, price
FROM products
WHERE price > ALL (SELECT
price 
FROM products
WHERE category = 'Accessories');

--Retrieve customers whose total purchase amount is higher than the average customer spending. 
SELECT c.customer_name,
       SUM(p.price * o.quantity) AS total_purchase
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name
HAVING SUM(p.price * o.quantity) > (SELECT
AVG(cust_spend) FROM
(SELECT SUM(p.price * o.quantity) AS cust_spend
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY o.customer_id) AS c);

--Show top 3 customers by total spending
SELECT c.customer_name, 
       SUM(p.price * o.quantity) AS total_spending
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spending DESC
LIMIT 3;

--Show month-wise total sales revenue.
SELECT EXTRACT(MONTH FROM o.order_date) AS month,
       ROUND(SUM(p.price * o.quantity),2) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY month;

--Display customers who purchased more than 1 category of products. 
SELECT c.customer_name, 
       COUNT(DISTINCT p.category) AS category_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT p.category) > 1;

--Show products whose total revenue > 20,000. 
SELECT p.product_name,
       SUM(p.price * o.quantity) AS total_revenue
FROM products p
JOIN orders o ON
p.product_id = o.product_id
GROUP BY p.product_name
HAVING SUM(p.price * o.quantity) > 800;

-- Create a view for customer purchase summary.
CREATE VIEW cust_purchase_summary AS 
(SELECT c.customer_id,
        c.customer_name,
		COUNT(DISTINCT o.order_id) AS total_orders,
		SUM(o.quantity) AS total_quantity,
		SUM(p.price * o.quantity) AS total_revenue
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name);

SELECT * FROM cust_purchase_summary;

--Use a CTE to calculate total revenue for each category. 
WITH total_revenue AS (
SELECT p.category,
       SUM(p.price * o.quantity) AS total_revenue
FROM products p 
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category)
SELECT *
FROM total_revenue;

--Use a Window Function to find category-wise average price. 
SELECT DISTINCT category,
       AVG(price) OVER(PARTITION BY category) AS avg_price
FROM products;

--Use a Window Function to rank customers by number of orders. 
SELECT RANK() OVER(ORDER BY total_orders) AS rn,
customer_id, 
customer_name, 
total_orders
FROM (SELECT c.customer_id,
             c.customer_name,
			 COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, 
         c.customer_name);

--Write a subquery to find products priced above the average product price.
SELECT product_name,
       price
FROM products
WHERE price > (SELECT AVG(price) AS avg_price
FROM products);

--Find products whose price is higher than every product in Accessories category. 
SELECT product_name,
       price
FROM products
WHERE price > ALL (SELECT price
FROM products
WHERE category = 'Accessories');