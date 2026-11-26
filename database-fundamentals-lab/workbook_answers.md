# SQL Pre-Work — Lesson 1: Database Fundamentals — Lab Answers
**Student:** Dakshayini M L

## Part 1 — Databases, Tables, Rows, and Columns
- **Q.1 — Identify the Database Objects:**
  - `customers`
  - `orders`
  - `products`
  - `order_items`
- **Q.2 — Identify Rows and Columns:**
  - **Row:** Represents one single customer record.
  - **Column:** Represents one specific attribute stored for every customer (e.g., `email` or `city`).
- **Q.3 — Choose DBMS or RDBMS:**
  - **RDBMS** is the better fit because data is structured into related tables and relationships between them are enforced via primary/foreign keys and constraints.
- **Q.4 — MCQ (Table Meaning):** **B** — One order record

## Part 2 — Keys and Constraints
- **Q.5 — Choose a Primary Key:** `customer_id` is the best primary key because it uniquely identifies each customer record and provides a stable reference for child tables like `orders`.
- **Q.6 — Find Candidate Keys:** `customer_id` and `email` (both uniquely identify a row; one becomes the Primary Key while the other is enforced with a `UNIQUE` constraint).
- **Q.7 — Recognise a Composite Key:** `(order_id, product_id)` uniquely identifies one product line item inside a specific order.
- **Q.8 — MCQ (Primary Key Rule):** **B** — It uniquely identifies a row

## Part 3 — Foreign Keys and Relationships
- **Q.9 — One-to-Many Relationship:** One-to-many (`1:N`) from `customers` to `orders`. `orders.customer_id` is the foreign key referencing `customers.customer_id`.
- **Q.10 — One-to-One Relationship:** One-to-one (`1:1`) — each customer can have at most one optional `customer_profile` row, and each profile belongs to exactly one customer.
- **Q.11 — Resolve a Many-to-Many Relationship:** `order_items` acts as the bridge/junction table resolving the `M:N` relationship between `orders` and `products` while storing `quantity` and `unit_price`.
- **Q.12 — MCQ (Foreign Key Purpose):** **A** — To link related rows

## Part 4 — ER Thinking and Data Quality
- **Q.13 — Read a Simple ER Design (`customers 1 ---- many orders`):** One customer can place many orders, and each order belongs to exactly one customer via `orders.customer_id`.
- **Q.14 — Choose Useful Constraints:**
  - `customer_id`: Primary Key (`PRIMARY KEY`)
  - `email`: Unique and Required (`UNIQUE NOT NULL`)
  - `customer_name`: Required (`NOT NULL`)
- **Q.15 — Spot a Relationship Problem:** **Referential integrity** is violated because `orders.customer_id = 900` references a parent customer row that does not exist in `customers`.
- **Q.16 — MCQ (Many-to-Many Design):** **A** — A bridge/relationship table such as `order_items`

## Optional Practice
- **Q.17 — Natural Key vs. Generated Identifier:**
  - `sku`: Natural/business key (carries business meaning).
  - `product_id`: Generated/surrogate internal identifier.
- **Q.18 — Minimal Customer–Order Model:**
  - `customers(customer_id PK)`
  - `orders(order_id PK, customer_id FK -> customers.customer_id)`
  - Relationship: One-to-many (`1:N`).
- **Q.19 — Why Keys Matter to Pipelines:** Stable keys allow data pipelines to match the same entity across incremental loads, preserve joins between tables, detect orphaned/unmatched records, and prevent duplicate or misattributed records.
- **Q.20 — Integrated ER Design:**
  - `customers(customer_id PK)` `1 ---< many` `orders(order_id PK, customer_id FK)`
  - `orders(order_id PK)` `1 ---< many` `order_items(order_id PK/FK, product_id PK/FK, quantity, unit_price)` `many >--- 1` `products(product_id PK)`
