from datetime import datetime, timedelta

# Airflow is provided at runtime in the DAG environment; this suppresses
# editor warnings when the package is not installed in the local interpreter.
from airflow import DAG  # type: ignore[import-not-found]
from airflow.operators.python import PythonOperator  # type: ignore[import-not-found]

# -------------------------------------------------------------------
# Python Functions (ETL Tasks)
# -------------------------------------------------------------------

def extract_sales_data():
    """Step 1: Extract sales data from daily CSV files"""
    print("Extracting sales data from stores...")

def clean_sales_data():
    """Step 2: Clean and transform sales data, calculate totals"""
    print("Cleaning and transforming sales data...")

def load_sales_data():
    """Step 3: Load cleaned data into warehouse and generate reports"""
    print("Loading data into warehouse...")

# -------------------------------------------------------------------
# DAG Configuration & Structure
# -------------------------------------------------------------------

default_args = {
    'owner': 'retail_team',
    'depends_on_past': False,
    'email_on_failure': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=1),
}

with DAG(
    dag_id='retail_sales_etl_pipeline',
    default_args=default_args,
    description='LAB 1 - Retail Sales ETL Pipeline using PythonOperator',
    schedule_interval='@daily',         # Schedule daily jobs
    start_date=datetime(2026, 10, 1),
    catchup=False,
    tags=['lab1', 'retail', 'etl'],
) as dag:

    # Task 1: Extract
    extract_task = PythonOperator(
        task_id='extract_sales_data',
        python_callable=extract_sales_data,
    )

    # Task 2: Clean & Transform
    clean_task = PythonOperator(
        task_id='clean_sales_data',
        python_callable=clean_sales_data,
    )

    # Task 3: Load
    load_task = PythonOperator(
        task_id='load_sales_data',
        python_callable=load_sales_data,
    )

    # Define Task Dependencies (Sequential Pipeline)
    extract_task >> clean_task >> load_task
