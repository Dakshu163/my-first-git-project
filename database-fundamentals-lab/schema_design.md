# Order System Relational Model & ER Summary

## Tables & Keys
1. **customers** (`customer_id` PK, `email` UNIQUE NOT NULL, `customer_name` NOT NULL, `city`)
2. **orders** (`order_id` PK, `customer_id` FK -> `customers.customer_id`, `order_date`, `status`)
3. **products** (`product_id` PK, `sku` UNIQUE, `product_name`, `price`)
4. **order_items** (`order_id` PK/FK -> `orders.order_id`, `product_id` PK/FK -> `products.product_id`, `quantity`, `unit_price`)

## Relationships
- `customers` (1) -> (Many) `orders`
- `orders` (1) -> (Many) `order_items`
- `products` (1) -> (Many) `order_items`
- `order_items` resolves the Many-to-Many (`M:N`) relationship between `orders` and `products`.
