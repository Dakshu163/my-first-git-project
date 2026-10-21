from airflow import DAG # type: ignore
from airflow.operators.python_operator import PythonOperator # type: ignore
from airflow.operators.email import EmailOperator # type: ignore
from pendulum import datetime

def sample_task():
    print("Running a task before sending email.")

with DAG(
    dag_id='email_notification_dag',
    start_date=datetime(2024, 6, 1),
    schedule=None,
    catchup=False,
    tags=["email", "notification"],
) as dag:

    run_task = PythonOperator(
        task_id='run_sample_task',
        python_callable=sample_task,
    )

    send_email = EmailOperator(
        task_id='send_email',
        to='receiver@example.com',
        subject='Airflow Email Test - Success Notification',
        html_content='<p>Your task has completed successfully ✅</p>',
    )

    run_task >> send_email
    