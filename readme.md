# Demo Project: Ecommerce DBT-BigQuery Project

This project demonstrates how DBT can be used to model data to adhere to an Inmon DWH Architecture stored in Google BigQuery (BQ). 

Tools used: 
- Data Source: [The Look Ecommerce BigQuery Public Data](https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=thelook_ecommerce&page=dataset&project=%3F&ws=!1m4!1m3!3m2!1sbigquery-public-data!2sthelook_ecommerce&inv=1&invt=Abq6kQ)
    - Data Dictionary can be found on [Kaggle](https://www.kaggle.com/datasets/mustafakeser4/looker-ecommerce-bigquery-dataset?select=users.csv)
    - *The data was loaded from a CSV to demonstrate a simple way of how to load CSV data into BQ.*
- Exploratory Data Analysis Tool: Jupyter Lab, Pandas, DuckDB, SQL
- Data Loader: Python Script using BigQuery API
- Transform: DBT
- Visualiation [WIP]: Looker Studio


# Problem Statement
The Look, a growing eCommerce clothing site, would like to make more data-driven decisions. They want you to prioritize helping the Sales & Marketing team and the Operations team.

After consultations with both teams, you identified the following.

## Sales & Marketing
- Wants to get a better understanding of the company's revenue drivers on a month-to-month basis
    - What are our top selling products? 
    - What's their biggest market? 
    - Who are their customers?
    - Where do their customers come from? 
- Is the company's profitability growing over time?


## Operations
- Wants to know if they're keeping up with their orders.
- Which warehouses should they expand the capacity of?


# Caveats & Observations
- The prescribed retail_price is always equal to the sale price
- The location of the user is the delivery location
- All Timestamps are in UTC
- Not all items in the `inventory_items` table can be found in the `order_items` table.
