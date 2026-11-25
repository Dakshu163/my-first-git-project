from kafka import KafkaProducer
from faker import Faker
import json
import random
import time
from datetime import datetime

fake = Faker()

producer = KafkaProducer(
    bootstrap_servers='127.0.0.1:9092',
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

products = ['Laptop', 'Phone', 'Tablet', 'Headphones']
cities = ['Mumbai', 'Delhi', 'Bangalore', 'Pune']
payments = ['UPI', 'Card', 'Cash']

order_id = 1

while True:

    order = {
        "order_id": order_id,
        "customer_name": fake.name(),
        "city": random.choice(cities),
        "product": random.choice(products),
        "amount": round(random.uniform(500, 80000), 2),
        "payment_mode": random.choice(payments),
        "order_time": str(datetime.now())
    }

    producer.send('ecommerce_orders', value=order)

    print("Sent:", order)

    order_id += 1

    time.sleep(2)
