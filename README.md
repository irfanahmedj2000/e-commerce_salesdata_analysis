# e-commerce_salesdata_analysis
Data analytics project for a furniture company based on ecommerce data got from the client.
# 📊 Sales Data Analysis & Business Intelligence Dashboard

## Overview

This project demonstrates an end-to-end Data Analytics workflow using Python, PostgreSQL, and Power BI. The objective was to clean and analyze sales data, identify business trends, understand product returns and cancellations, and provide actionable insights through interactive dashboards.

The project follows a real-world analytics pipeline from data preparation to business reporting.

---

## Dataset

The project uses multiple datasets related to an e-commerce business, including:

* Sales Data
* Returns Report
* Cancellation Report
* Search Traffic Report
* Earn More Report

These datasets were cleaned, transformed, and analyzed to generate meaningful business insights.

---

## Tools & Technologies

* **Python**

  * Pandas
  * NumPy
  * Jupyter Notebook

* **PostgreSQL**

  * SQL
  * pgAdmin 4

* **Power BI**

  * Data Modeling
  * DAX Measures
  * Interactive Dashboards

---

## Project Workflow

### 1. Data Loading

* Imported raw CSV datasets into Python.
* Loaded the data using Pandas for analysis.

### 2. Data Cleaning

* Removed duplicate records.
* Handled missing values.
* Renamed columns for readability.
* Corrected data types.
* Created additional date-related columns.
* Exported cleaned datasets.

### 3. SQL Analysis (PostgreSQL)

Imported cleaned datasets into PostgreSQL and performed SQL analysis to answer business questions such as:

* Total Revenue
* Total Orders
* Average Order Value
* Revenue by State
* Revenue by Product
* Weekend vs Weekday Sales
* Discount Impact on Sales
* Repeat Customers
* Return Analysis
* Cancellation Analysis
* Search Traffic Analysis
* Conversion Rate Analysis

---

## Power BI Dashboard

An interactive Power BI dashboard was created to visualize business performance.

### Dashboard Pages

**Page 1 – Executive Dashboard**

* Total Revenue
* Total Orders
* Average Order Value
* Revenue by State
* Revenue by Product

**Page 2 – Sales Performance**

* Product Performance
* Revenue Analysis
* Weekday vs Weekend Sales
* Discount Analysis

**Page 3 – Return Analysis**

* Return Reasons
* Return Rate
* Product-wise Returns
* Return Amount Analysis

**Page 4 – Cancellation Analysis**

* Cancellation Reasons
* Cancellation Rate
* Product-wise Cancellations
* Cancellation Trends

**Page 5 – Growth & Marketing Insights**

* Product Views
* Product Clicks
* Click Through Rate (CTR)
* Conversion Rate
* Revenue Opportunities

---

## Key Results

The analysis provided valuable business insights, including:

* Identified top-performing products by revenue.
* Discovered products with the highest return and cancellation rates.
* Compared weekday and weekend sales performance.
* Evaluated the impact of discounts on customer purchases.
* Identified products with high customer interest but low conversion.
* Highlighted opportunities to improve marketing performance and increase profitability.

---

## Project Structure

```text
Sales_Data_Analysis/
│
├── data/
│   ├── raw/
│   └── cleaned/
│
├── notebooks/
│   └── data_cleaning.ipynb
│
├── sql/
│   └── analysis_queries.sql
│
├── powerbi/
│   └── Sales_Dashboard.pbix
│
├── report/
│   └── Business_Report.pdf
│
└── README.md
```

---

## How to Run

1. Clone this repository.
2. Install the required Python libraries.
3. Open the Jupyter Notebook and run the data cleaning process.
4. Import the cleaned datasets into PostgreSQL.
5. Execute the SQL queries for analysis.
6. Open the Power BI (.pbix) file to explore the interactive dashboard.

---

## Skills Demonstrated

* Data Cleaning
* Exploratory Data Analysis (EDA)
* SQL Query Writing
* Database Management
* Data Modeling
* Business Intelligence
* Dashboard Development
* Data Visualization
* Business Insight Generation

---

---

## Author

**Irfan Ahmed**

Master's in Web & Data Science

End-to-End Data Analytics Project using Python, PostgreSQL, and Power BI.
