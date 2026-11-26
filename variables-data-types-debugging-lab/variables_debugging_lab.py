"""
Python Pre-Work — Lesson 2: Variables, Data Types, Type Casting, and Basic Debugging
Student: Dakshayini M L
"""

print("=== Part 1: Variables and Data Types ===")
# Q.1 - Create your first variables
student_name = "Amit"
student_age = 24
student_city = "Mumbai"
course_name = "Data Engineering"
print(student_name, student_age, student_city, course_name)

# Q.2 - Use meaningful variable names
product_name = "Keyboard"
product_price = 1200
quantity = 2
total_amount = product_price * quantity
print(product_name)
print(total_amount)

# Q.3 - Check data types
order_id = 1001
order_amount = 2499.50
customer_name = "Neha"
payment_done = True
print(type(order_id))
print(type(order_amount))
print(type(customer_name))
print(type(payment_done))

print("\n=== Part 2: Type Casting and Operators ===")
# Q.5 - Convert text into an integer
marks = "80"
marks = int(marks)
print(marks + 10)

# Q.6 - Convert price and quantity
price = "499.99"
quantity = "3"
total_amount = float(price) * int(quantity)
print(total_amount)

# Q.7 - Practise arithmetic operators
a = 10
b = 3
print(a + b)
print(a - b)
print(a * b)
print(a / b)
print(a // b)
print(a % b)
print(a ** b)

print("\n=== Part 3: Comparisons, Input, and Output ===")
# Q.9 - Compare two values
order_amount = 2500
print(order_amount > 2000)
print(order_amount == 2500)
print(order_amount != 1000)
print(order_amount <= 2000)

# Q.10 - Combine conditions
age = 25
has_id = True
is_allowed = age >= 18 and has_id
print(is_allowed)

# Q.11 - Take numeric input (simulated with sample values 10 and 20)
num1 = int("10")
num2 = int("20")
result = num1 + num2
print("Sum of 10 and 20:", result)

print("\n=== Part 4: Formatting, Comments, and Debugging ===")
# Q.13 - Print a clear f-string
customer_name = "Priya"
order_amount = 3500.50
print(f"Customer {customer_name} has an order amount of {order_amount}")

# Q.14 - Add useful comments
# Store product values
product_price = 1500
quantity = 2
# Calculate the total bill
total_bill = product_price * quantity
# Display the final amount
print(total_bill)

# Q.15 - Fix five basic errors
print("Hello")                          # 1. Fixed SyntaxError
student_name = "Amit"                   # 2. Fixed NameError
print(student_name)
age = 25                                # 3. Fixed TypeError
print("Age is " + str(age))
marks = int("80")                       # 4. Fixed ValueError
print(marks)
amount = 100                            # 5. Fixed IndentationError
print(amount)

print("\n=== Optional Practice (Q.17 - Q.20) ===")
# Q.17 - Simple bill calculator (simulated input)
p_name = "Monitor"
p_price = float("12500.0")
p_qty = int("2")
print(f"Product: {p_name}")
print(f"Total: {p_price * p_qty}")

# Q.18 - Check discount eligibility without if
order_amount = 4500
is_member = True
discount_eligible = order_amount > 2000 and is_member
print(discount_eligible)

# Q.19 - Debug user input string concatenation ("10" + "20" -> 30)
n1 = int("10")
n2 = int("20")
print(n1 + n2)

# Q.20 - Customer billing script (simulated input)
c_name = "Dakshayini"
prod_name = "Laptop"
unit_price = float("55000.0")
qty = int("1")
total_amt = unit_price * qty
premium_discount_eligible = total_amt > 5000
print(f"Customer: {c_name}")
print(f"Product: {prod_name}")
print(f"Total: {total_amt}")
print("Premium Discount Eligible:", premium_discount_eligible)
