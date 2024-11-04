# Olist E-commerce Data Transformation Project

## Project Overview

This project uses dbt (Data Build Tool) to transform and model data from the **Brazilian E-Commerce Public Dataset by Olist**. The goal is to organize, clean, and transform raw data from PostgreSQL into analytics-ready models for analysis in Tableau. This setup also includes data quality checks and governance measures to ensure data integrity across the pipeline.

## Data Source

The data used in this project is from Olist, a Brazilian e-commerce platform. The dataset includes information about orders, products, sellers, customers, reviews, and payments. The main tables in the dataset include:

- **olist_sellers_dataset**: Contains seller information.
- **olist_marketing_qualified_leads_dataset**: Holds data about leads qualified through marketing channels.
- **product_category_name_translation**: Provides translations for product category names.
- **olist_orders_dataset**: Contains order information, including order dates, statuses, and customer IDs.
- **olist_order_items_dataset**: Details individual items within orders.
- **olist_customers_dataset**: Contains customer information, such as unique IDs and geographical data.
- **olist_geolocation_dataset**: Includes geolocation data for various zip codes.
- **olist_order_payments_dataset**: Holds payment information related to orders.
- **olist_closed_deals_dataset**: Contains information on closed deals.
- **olist_order_reviews_dataset**: Includes customer reviews and ratings.
- **olist_products_dataset**: Provides information about products available on the platform.

## Project Structure and Models

### 1. **Source Configuration**

Each source table is defined in `src_olist.yml`, which serves as a configuration for the raw data. This configuration specifies the tables and columns, helping dbt understand the raw data structure and apply data quality checks at the source level.

### 2. **Staging Models**

The staging layer is responsible for cleaning and standardizing the raw data. Staging models include transformations that:
- Rename columns for consistency.
- Filter and format fields as needed.
- Join tables where necessary to enrich datasets.

**Example Staging Models:**
- `stg_customers.sql`: Extracts and organizes customer information.
- `stg_orders.sql`: Cleans and formats order data, including calculating `delivery_delay` as the number of days between estimated and actual delivery dates.

### 3. **Transformation Models**

Transformation models are built on top of the staging layer to add business logic and further calculations. These models are designed to be analytics-ready and can be directly consumed by reporting tools like Tableau.

**Example Transformation Model:**
- `customer_metrics.sql`: This model aggregates customer-level data to calculate key metrics such as the total number of orders and total spend by each customer.

### 4. **Data Quality Checks**

To ensure data integrity, various data quality checks have been incorporated:
- **Not Null**: Ensures critical fields (e.g., `order_id`, `customer_id`) contain data.
- **Uniqueness**: Ensures primary keys, like `order_id`, are unique.
- **Accepted Values**: Confirms that fields like `order_status` only contain valid values (e.g., `delivered`, `shipped`, `canceled`, `processing`).

These checks are defined in YAML files and are executed automatically in dbt.

### 5. **Data Scorecard and Governance**

A data scorecard model has been implemented to monitor the quality of critical fields, such as:
- Completeness (percentage of non-null fields).
- Uniqueness of key identifiers.
- Ratio of delayed deliveries.

These metrics provide visibility into data quality trends, enabling continuous monitoring and early detection of issues.

### 6. **Documentation and Lineage**

The project includes auto-generated documentation with descriptions for each model, table, and column. This enhances traceability and governance by providing transparency into data transformations.


## Getting Started

1. **Install Dependencies**: Ensure you have dbt installed with the PostgreSQL adapter:
   ```bash
   pip install dbt-postgres
2. **Set Up Database Connection**: Configure the profiles.yml in the .dbt directory with your PostgreSQL credentials.
3. **Run dbt Models**:  dbt run
4. **Run Tests**: dbt test
5. **View Documentation**: Generate and serve dbt documentation to explore model lineage and metadata: dbt docs generate  , dbt docs serve

Next Steps
1. The final output models are deployed in the `olist_analytics` schema in PostgreSQL, making them accessible to Tableau for further analysis and visualization. Tableau dashboards created with this data enable analysis of customer behavior, order trends, and delivery performance.
2. Expand Metrics: Create additional transformation models for more in-depth analysis.
3. Enhance Data Quality Rules: Refine and add new rules as needed.
4. Optimize Performance: Tune query performance and database configurations if necessary.

