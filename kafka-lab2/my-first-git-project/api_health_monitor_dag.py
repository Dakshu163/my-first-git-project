from datetime import datetime, timedelta
import urllib.request
import ssl

from airflow import DAG  # type: ignore
from airflow.operators.python import PythonOperator  # type: ignore

def check_api_health():
    """Checks the status of an external endpoint."""
    url = "https://httpbin.org/status/200"
    print(f"Pinging endpoint: {url}")
    
    # Bypass local SSL verification for testing purposes in Codespaces
    context = ssl._create_unverified_context()
    
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Airflow-Health-Check'})
        with urllib.request.urlopen(req, context=context, timeout=10) as response:
            status_code = response.getcode()
            print(f"API Response Code: {status_code}")
            if status_code == 200:
                print("HEALTH CHECK PASSED: API is online and responding.")
                return True
            else:
                raise ValueError(f"HEALTH CHECK FAILED: API returned status {status_code}")
    except Exception as e:
        print(f"Error connecting to API: {str(e)}")
        raise e

default_args = {
    'owner': 'devops_team',
    'depends_on_past': False,
    'start_date': datetime(2026, 10, 1),
    'retries': 2,
    'retry_delay': timedelta(seconds=30),
}

with DAG(
    dag_id='api_health_monitor_dag',
    default_args=default_args,
    description='LAB 3 - Automated API Health Check & Monitoring',
    schedule_interval='*/15 * * * *',  # Runs every 15 minutes
    catchup=False,
    tags=['lab3', 'api', 'monitoring'],
) as dag:

    api_check_task = PythonOperator(
        task_id='check_api_endpoint',
        python_callable=check_api_health,
    )

    api_check_task
