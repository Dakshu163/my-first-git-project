"""
Python Pre-Work — Lesson 5: Functions and Modular Code
Student: Dakshayini M L
"""

from math_ops import multiply
from text_utils import clean_string as text_clean
from number_utils import parse_int as num_parse
from etl_utils import clean_string, is_valid_row, parse_int

print("=== Part 1: Define and Call Functions ===")
# Q.1 - Write a simple function
def greet(name):
    return f"Hello, {name}!"

print(greet("Alice"))

# Q.2 - Use two parameters
def format_name(first, last):
    return f"{last}, {first}"

print(format_name("Ada", "Lovelace"))

# Q.3 - Positional and keyword arguments
def create_record(id, name, active=True):
    return {"id": id, "name": name, "active": active}

print(create_record(101, "Alice"))
print(create_record(name="Bob", id=102, active=False))

print("\n=== Part 2: Defaults, *args, **kwargs, and Returns ===")
# Q.5 - Use a default argument
def connect(host="localhost", port=5432):
    return host, port

print(connect())
print(connect(port=5433))

# Q.6 - Avoid a mutable default
def add_item(value, items=None):
    if items is None:
        items = []
    items.append(value)
    return items

print(add_item(1))
print(add_item(2))

# Q.7 - Sum flexible inputs with *args
def sum_values(*values):
    total = 0
    for value in values:
        total = total + value
    return total

print(sum_values(10, 20, 30))

print("\n=== Part 3: **kwargs, Return Values, and Scope ===")
# Q.9 - Build a record with **kwargs
def build_record(**fields):
    return fields

print(build_record(id=1, name="Alice", active=True))

# Q.10 - Return more than one value
def split_name(full_name):
    first, last = full_name.split()
    return first, last

first_name, last_name = split_name("Grace Hopper")
print(first_name)
print(last_name)

# Q.11 - Prefer return to only printing
def add(a, b):
    return a + b

result = add(10, 20)
print(result)

print("\n=== Part 4: Reusable Utilities and Modules ===")
# Q.13 - Reusable cleaning function
print(clean_string("  ALICE  "))

# Q.14 - Safe integer parser
print(parse_int("25"))
print(parse_int("wrong", default=-1))

# Q.15 - Import and use custom module (math_ops.py)
print(multiply(6, 7))

print("\n=== Optional Practice (Q.17 - Q.20) ===")
# Q.17 - Clean one CSV-style record
def clean_record(line):
    id_text, name_text, age_text = line.split(",")
    return {
        "id": id_text.strip(),
        "name": clean_string(name_text),
        "age": parse_int(age_text),
    }

print(clean_record("101, Alice ,30"))

# Q.18 - Build a flexible aggregator
def aggregate_column(*values, skip_none=True):
    total = 0
    for value in values:
        if skip_none and value is None:
            continue
        if value is not None:
            total = total + value
    return total

print(aggregate_column(5, None, 10))

# Q.19 - Use two utility modules (text_utils.py & number_utils.py)
print(text_clean("  PRIYA  "))
print(num_parse("31"))

# Q.20 - Small modular data cleaner (etl_utils.py)
lines = [
    "101, Alice ,30",
    "102,Bob,notanumber",
    " ,NoID,25",
    "103,Carol,40",
]

rows = []
for line in lines:
    id_text, name_text, age_text = line.split(",")
    row = {
        "id": id_text.strip(),
        "name": clean_string(name_text),
        "age": parse_int(age_text),
    }
    if is_valid_row(row):
        rows.append(row)

total_age = sum(row["age"] for row in rows)
count = len(rows)
average_age = total_age / count if count else 0

print("Valid rows:", count)
print("Average age:", average_age)
