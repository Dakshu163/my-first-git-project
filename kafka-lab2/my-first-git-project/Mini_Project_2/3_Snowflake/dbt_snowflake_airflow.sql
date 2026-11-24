USE ROLE ACCOUNTADMIN;

CREATE WAREHOUSE IF NOT EXISTS dbt_snowflake_wh
WITH WAREHOUSE_SIZE = 'XSMALL'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE;

CREATE DATABASE IF NOT EXISTS dbt_snowflake_db;
CREATE ROLE IF NOT EXISTS dbt_snowflake_role;
CREATE SCHEMA IF NOT EXISTS dbt_snowflake_db.dbt_snowflake_schema;



GRANT USAGE ON WAREHOUSE dbt_snowflake_wh TO ROLE dbt_snowflake_role;

GRANT ALL ON DATABASE dbt_snowflake_db TO ROLE dbt_snowflake_role;

GRANT USAGE ON SCHEMA dbt_snowflake_db.dbt_snowflake_schema TO ROLE dbt_snowflake_role;

GRANT ROLE dbt_snowflake_role TO USER DAKSHU;



GRANT CREATE TABLE ON SCHEMA dbt_snowflake_db.dbt_snowflake_schema 
TO ROLE dbt_snowflake_role;

GRANT CREATE VIEW
ON SCHEMA dbt_snowflake_db.dbt_snowflake_schema 
TO ROLE dbt_snowflake_role;