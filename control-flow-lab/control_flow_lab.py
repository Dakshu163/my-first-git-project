"""
Python Pre-Work — Lesson 3: Control Flow
Student: Dakshayini M L
"""

print("=== Part 1: if, elif, and else ===")
# Q.1 - Write a basic if
order_amount = 1200
if order_amount > 0:
    print("Valid order amount")

# Q.2 - Pass or fail
marks = 72
if marks >= 40:
    print("Passed")

# Q.3 - Classify an order
order_amount = 2500
if order_amount >= 5000:
    print("High value order")
elif order_amount >= 1000:
    print("Medium value order")
else:
    print("Low value order")

print("\n=== Part 2: Nested Conditions ===")
# Q.5 - Two-level approval
customer_status = "active"
order_amount = 3500
if customer_status == "active":
    if order_amount >= 3000:
        print("Order approved with priority")

# Q.6 - Handle all nested outcomes
record_found = True
record_valid = False
if record_found:
    if record_valid:
        print("Process record")
    else:
        print("Reject invalid record")
else:
    print("Record not found")

# Q.7 - Compare nested and combined conditions
age = 25
has_id = True
# Nested version
if age >= 18:
    if has_id:
        print("Allowed (nested)")
# Combined version
if age >= 18 and has_id:
    print("Allowed (combined)")

print("\n=== Part 3: for and while ===")
# Q.9 - Loop through a range
for number in range(1, 6):
    print(number)

# Q.10 - Calculate a running total (1 to 5)
total = 0
for number in range(1, 6):
    total = total + number
print("Running total:", total)

# Q.11 - Use a while loop
number = 1
while number <= 5:
    print(number)
    number = number + 1

print("\n=== Part 4: break and continue ===")
# Q.13 - Stop at a target number (5)
for number in range(1, 11):
    print(number)
    if number == 5:
        break

# Q.14 - Skip even numbers
for number in range(1, 11):
    if number % 2 == 0:
        continue
    print(number)

# Q.15 - Stop after three valid values (> 4)
valid_count = 0
for number in range(1, 11):
    if number > 4:
        print("Valid:", number)
        valid_count = valid_count + 1
    if valid_count == 3:
        break

print("\n=== Optional Practice (Q.17 - Q.20) ===")
# Q.17 - Grade classification
score = 83
if score >= 90:
    print("Excellent")
elif score >= 70:
    print("Good")
elif score >= 40:
    print("Average")
else:
    print("Needs improvement")

# Q.18 - Validate repeated numeric input (simulated inputs: -2, 0, 7)
simulated_inputs = iter([-2, 0, 7])
number = next(simulated_inputs)
while number <= 0:
    print(f"Invalid value: {number}")
    number = next(simulated_inputs)
print("Accepted:", number)

# Q.19 - Count valid positive numbers in range(-3, 6)
valid_count = 0
for number in range(-3, 6):
    if number <= 0:
        continue
    print(number)
    valid_count = valid_count + 1
print("Valid count:", valid_count)

# Q.20 - Build a simple retry counter
attempt = 1
while attempt <= 3:
    print("Attempt:", attempt)
    attempt = attempt + 1
print("Maximum attempts reached")
