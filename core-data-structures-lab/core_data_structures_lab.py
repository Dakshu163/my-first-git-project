"""
Python Pre-Work — Lesson 4: Core Data Structures
Student: Dakshayini M L
"""

print("=== Part 1: Lists and Tuples ===")
# Q.1 - Create and read a list
files = ["customers.csv", "orders.csv", "payments.csv"]
print(files[0])
print(files[2])

# Q.2 - Update a list
topics = ["Python", "SQL"]
topics.append("Spark")
topics.remove("SQL")
print(topics)

# Q.3 - Use a tuple for fixed values
order_schema = ("order_id", "customer_id", "amount")
print(order_schema[1])

print("\n=== Part 2: Sets and Dictionaries ===")
# Q.5 - Remove duplicates with a set
customer_ids = [101, 102, 101, 103, 102]
unique_customer_ids = set(customer_ids)
print(unique_customer_ids)

# Q.6 - Add and remove set values
processed_files = {"customers.csv", "orders.csv"}
processed_files.add("payments.csv")
processed_files.remove("orders.csv")
print(processed_files)

# Q.7 - Create a dictionary record
product = {
    "product_id": 501,
    "product_name": "Keyboard",
    "price": 1200,
}
print(product["product_name"])
print(product["price"])

print("\n=== Part 3: Dictionaries and Nested Data ===")
# Q.9 - Update and add dictionary fields
customer = {
    "customer_id": 101,
    "name": "Rahul",
    "city": "Pune",
}
customer["city"] = "Mumbai"
customer["status"] = "active"
print(customer)

# Q.10 - Read a missing key safely with .get()
customer = {
    "customer_id": 101,
    "name": "Rahul",
}
city = customer.get("city", "City not available")
print(city)

# Q.11 - Read a nested dictionary
order = {
    "order_id": 9001,
    "amount": 2500,
    "customer": {
        "name": "Priya",
        "city": "Nagpur",
    },
}
print(order["customer"]["city"])

print("\n=== Part 4: Comprehensions and Choosing Structures ===")
# Q.13 - Filter a list with list comprehension
amounts = [1000, 2500, 0, -300, 4500]
valid_amounts = [amount for amount in amounts if amount > 0]
print(valid_amounts)

# Q.14 - Transform a list with list comprehension
names = ["rahul", "priya", "amit"]
uppercase_names = [name.upper() for name in names]
print(uppercase_names)

# Q.15 - Create a dictionary with comprehension
files = ["customers.csv", "orders.csv", "payments.csv"]
file_status = {file_name: "pending" for file_name in files}
print(file_status)

print("\n=== Optional Practice (Q.17 - Q.20) ===")
# Q.17 - Count values by category
cities = ["Pune", "Mumbai", "Pune", "Delhi", "Mumbai", "Pune"]
city_counts = {}
for city in cities:
    city_counts[city] = city_counts.get(city, 0) + 1
print(city_counts)

# Q.18 - Build accepted and rejected lists
amounts = [500, 0, 1200, -100, 700]
accepted = []
rejected = []
for amount in amounts:
    if amount > 0:
        accepted.append(amount)
    else:
        rejected.append(amount)
print("Accepted:", accepted)
print("Rejected:", rejected)

# Q.19 - Build nested order records
orders = [
    {
        "order_id": 1001,
        "amount": 1500,
        "customer": {"name": "Amit", "city": "Pune"},
    },
    {
        "order_id": 1002,
        "amount": 2200,
        "customer": {"name": "Neha", "city": "Mumbai"},
    },
]
for order in orders:
    print(order["order_id"], order["customer"]["city"])

# Q.20 - Choose the right structure
unique_customer_ids = {101, 102, 103}
column_names = ("order_id", "customer_id", "amount")
customer = {"customer_id": 101, "name": "Rahul", "city": "Pune"}
daily_sales = [1200, 1800, 950]
print(unique_customer_ids)
print(column_names)
print(customer)
print(daily_sales)
