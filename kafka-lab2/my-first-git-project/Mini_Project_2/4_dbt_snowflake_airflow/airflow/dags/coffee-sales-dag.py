from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.empty import EmptyOperator

default_args = {
    "owner": "brewbeats_data_eng",
    "depends_on_past": False,
    "email_on_failure": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    dag_id="coffee_sales_dbt_pipeline",
    default_args=default_args,
    description="Daily ELT pipeline orchestrating dbt transformations on Snowflake",
    schedule="@daily",
    start_date=datetime(2026, 1, 1),
    catchup=False,
    tags=["brewbeats", "snowflake", "dbt"],
) as dag:

    start_pipeline = EmptyOperator(task_id="start_pipeline")

    dbt_debug_task = BashOperator(
        task_id="verify_snowflake_connection",
        bash_command="cd /opt/airflow/dbt/dbt_snowflake_airflow && dbt debug",
    )

    dbt_run_task = BashOperator(
        task_id="dbt_run_snowflake_models",
        bash_command="cd /opt/airflow/dbt/dbt_snowflake_airflow && dbt run",
    )

    dbt_test_task = BashOperator(
        task_id="dbt_test_snowflake_quality",
        bash_command="cd /opt/airflow/dbt/dbt_snowflake_airflow && dbt test",
    )

    end_pipeline = EmptyOperator(task_id="end_pipeline")

    start_pipeline >> dbt_debug_task >> dbt_run_task >> dbt_test_task >> end_pipeline