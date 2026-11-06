from datetime import datetime, timedelta
import logging
from airflow import DAG
from airflow.operators.email import EmailOperator
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.sensors.filesystem import FileSensor

# Default DAG configuration
default_args = {
    'owner': 'data_engineering',
    'depends_on_past': False,
    'email': ['alerts@quickcart.com'],
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 3,
    'retry_delay': timedelta(minutes=5),
}


def extract_and_validate_csv(**context):
  """Validates raw CSV files on disk before staging."""
  import os
  import pandas as pd

  files = [
      '/opt/airflow/data/customers.csv',
      '/opt/airflow/data/orders.csv',
      '/opt/airflow/data/products.csv',
  ]
  for filepath in files:
    if not os.path.exists(filepath):
      raise FileNotFoundError(f'Validation failed: Missing file {filepath}')
    df = pd.read_csv(filepath)
    if df.empty:
      raise ValueError(f'Validation failed: Empty dataset at {filepath}')
    logging.info(
        f'File {filepath} validated successfully with {len(df)} records.'
    )


def load_csv_to_postgres_staging(**context):
  """Loads validated CSVs into PostgreSQL staging tables."""
  pg_hook = PostgresHook(postgres_conn_id='postgres_quickcart')
  conn = pg_hook.get_conn()
  cursor = conn.cursor()

  tables = {
      'stg_customers': '/opt/airflow/data/customers.csv',
      'stg_orders': '/opt/airflow/data/orders.csv',
  }

  for table, file_path in tables.items():
    cursor.execute(f'TRUNCATE TABLE {table};')
    with open(file_path, 'r') as f:
      next(f)  # Skip header row
      cursor.copy_expert(f'COPY {table} FROM STDIN WITH CSV HEADER', f)
    conn.commit()
    logging.info(f'Loaded {file_path} into staging table {table}.')


# Define DAG instance
with DAG(
    dag_id='quickcart_daily_elt_pipeline',
    default_args=default_args,
    description='Daily QuickCart ELT Pipeline running at 2 AM',
    schedule_interval='0 2 * * *',  # Daily at 2:00 AM
    start_date=datetime(2025, 1, 1),
    catchup=False,
    tags=['quickcart', 'elt', 'production'],
) as dag:

  # 1. File Sensors to ensure source data availability
  wait_for_orders_file = FileSensor(
      task_id='wait_for_orders_file',
      filepath='/opt/airflow/data/orders.csv',
      poke_interval=60,
      timeout=3600,
  )

  # 2. Extract and Validate
  validate_data_task = PythonOperator(
      task_id='extract_and_validate_csv',
      python_callable=extract_and_validate_csv,
  )

  # 3. Create Staging Tables
  create_staging_tables = PostgresOperator(
      task_id='create_staging_tables',
      postgres_conn_id='postgres_quickcart',
      sql="""
        CREATE TABLE IF NOT EXISTS stg_customers (
            customer_id INT,
            customer_name VARCHAR(100),
            email VARCHAR(100),
            city VARCHAR(50),
            signup_date DATE
        );
        CREATE TABLE IF NOT EXISTS stg_orders (
            order_id INT,
            customer_id INT,
            product_id INT,
            order_date TIMESTAMP,
            quantity INT,
            unit_price NUMERIC(10,2),
            payment_status VARCHAR(50)
        );
        """,
  )

  # 4. Load Data to Staging
  load_staging_task = PythonOperator(
      task_id='load_csv_to_staging',
      python_callable=load_csv_to_postgres_staging,
  )

  # 5. Transform Staging Data into Analytics Mart
  transform_data_task = PostgresOperator(
      task_id='transform_and_load_analytics',
      postgres_conn_id='postgres_quickcart',
      sql="""
        CREATE TABLE IF NOT EXISTS fact_daily_sales AS
        SELECT 
            CAST(order_date AS DATE) AS sale_date,
            COUNT(DISTINCT order_id) AS total_orders,
            SUM(quantity * unit_price) AS total_revenue
        FROM stg_orders
        WHERE payment_status = 'Completed'
        GROUP BY CAST(order_date AS DATE);
        """,
  )

  # 6. Failure Email Notification
  failure_email = EmailOperator(
      task_id='send_failure_email',
      to='alerts@quickcart.com',
      subject='Airflow Alert: QuickCart ELT Pipeline Failed',
      html_content='<h3>The daily ELT pipeline failed. Please check Airflow task logs.</h3>',
      trigger_rule='one_failed',
  )

  # Task Dependency Workflow Execution Order
 # Task Dependency Workflow Execution Order
(
    wait_for_orders_file
    >> validate_data_task
    >> create_staging_tables
    >> load_staging_task
    >> transform_data_task
    >> failure_email
)
[
    validate_data_task,
    create_staging_tables,
    load_staging_task,
    transform_data_task,
] >> failure_email