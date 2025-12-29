# Retail Sales Analytics — End-to-End SQL Case Study

## Overview
This project demonstrates an **end-to-end SQL analytics workflow** on a retail sales database. The analysis models a real-world transactional system and extracts **business-critical insights** related to customer behavior, product performance, and revenue trends.

The project is designed to showcase **production-ready SQL skills**, including data modeling, complex joins, aggregations, subqueries, CTEs, window functions, and reusable views.

---

## Business Problem
Retail organizations require accurate and timely insights to:
- Understand customer purchasing behavior
- Identify high-performing products and categories
- Track revenue growth and seasonal trends
- Retain high-value customers

This project answers those questions using SQL-driven analysis.

## Dataset Description

### Entities
The database consists of three normalized tables:

#### Customers
Stores customer demographic and registration details.

| Column | Description |
|------|-------------|
| customer_id | Primary key |
| customer_name | Customer name |
| city | City of residence |
| registration_date | Registration date |

#### Products
Contains product and pricing information.

| Column | Description |
|------|-------------|
| product_id | Primary key |
| product_name | Product name |
| category | Product category |
| price | Unit price |

#### Orders
Transactional order data linking customers and products.

| Column | Description |
|------|-------------|
| order_id | Primary key |
| customer_id | Foreign key → customers |
| product_id | Foreign key → products |
| order_date | Order date |
| quantity | Units purchased |


## Data Modeling & Integrity
- Enforced **primary and foreign key constraints**
- Applied **data validation checks** on price and quantity
- Ensured referential integrity across all tables
- Standardized date formats for time-based analysis


## SQL Techniques Demonstrated
- Data Definition & Manipulation (DDL / DML)
- INNER JOIN & LEFT JOIN
- Aggregations (`SUM`, `COUNT`, `AVG`)
- Filtering & sorting
- Subqueries (scalar, correlated, nested)
- Common Table Expressions (CTEs)
- Window Functions (`RANK`, `AVG OVER`)
- Views for reusable reporting layers


## Key Analytical Use Cases
- Customer-level revenue and order frequency analysis
- Product-wise and category-wise sales performance
- Identification of best-selling and high-revenue products
- Detection of high-value customers
- Month-wise revenue trend analysis
- Multi-category purchase behavior


## Business Insights
- **Electronics category generates the highest revenue**
- **Top customers contribute disproportionately to total sales**
- **Mobile phones and headphones show sustained demand**
- **Sales volume peaks during July 2023**
- **Customers purchasing across multiple categories exhibit higher lifetime value**


## Conclusion
This project highlights how SQL can be used to transform raw transactional data into **actionable business intelligence**. By leveraging advanced querying techniques, the analysis provides meaningful insights that support strategic decision-making in retail operations.


## Recommendations
- Prioritize inventory and marketing efforts toward high-performing electronics products
- Implement loyalty programs for top-spending customers
- Maintain sufficient stock for consistently demanded items
- Align promotional campaigns with peak sales periods
- Encourage cross-category purchasing to increase revenue per customer


## Future Enhancements
- Extend analysis using time-series forecasting
- Integrate with Power BI / Tableau dashboards
- Add customer behavior metrics (returns, discounts, sessions)
- Use Python for advanced analytics and automation


