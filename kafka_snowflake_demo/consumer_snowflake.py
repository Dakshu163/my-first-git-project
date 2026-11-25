from kafka import KafkaConsumer
import snowflake.connector
import json

consumer = KafkaConsumer(
    'ecommerce_orders',
    bootstrap_servers='127.0.0.1:9092',
    auto_offset_reset='earliest',
    value_deserializer=lambda x: json.loads(x.decode('utf-8'))
)

conn = snowflake.connector.connect(
    user='YOUR_SNOWFLAKE_USERNAME',
    password='YOUR_SNOWFLAKE_PASSWORD',
    account='xy12345.eu-west-1',
    warehouse='COMPUTE_WH',
    database='KAFKA_DEMO',
    schema='REALTIME',
    role='ACCOUNTADMIN'
)

cursor = conn.cursor()

print("Listening to Kafka...")

for message in consumer:

    try:

        data = message.value

        sql = f"""
        INSERT INTO orders
        VALUES (
            {data['order_id']},
            '{data['customer_name']}',
            '{data['city']}',
            '{data['product']}',
            {data['amount']},
            '{data['payment_mode']}',
            '{data['order_time']}'
        )
        """

        cursor.execute(sql)

        print("Inserted into Snowflake:", data)

    except Exception as e:
        print("ERROR:", e)
