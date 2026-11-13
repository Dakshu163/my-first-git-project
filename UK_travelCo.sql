CREATE WAREHOUSE IF NOT EXISTS travel_wh
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE;

USE WAREHOUSE travel_wh;
USE DATABASE travel_db;
USE SCHEMA public;

CREATE OR REPLACE FILE FORMAT csv_ff
  TYPE = CSV
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  NULL_IF = ('');

  CREATE OR REPLACE TABLE bookings (
  booking_id INT, booking_date DATE, customer_id STRING, customer_name STRING,
  home_city STRING, destination_city STRING, destination_country STRING,
  package_type STRING, travel_start_date DATE, nights INT, travellers INT,
  price_per_person_gbp NUMBER(10,2), discount_pct NUMBER(5,2),
  payment_mode STRING, status STRING, rating INT
);

USE DATABASE travel_db;
USE SCHEMA public;
CREATE OR REPLACE STAGE bookings_stage FILE_FORMAT = csv_ff;
-- Upload: Snowsight > Data > Databases > TRAVEL_DB > BOOKINGS > Stages > BOOKINGS_STAGE > + Files
-- (or SnowSQL: PUT file://uk_travel_bookings.csv @bookings_stage;)


COPY INTO bookings FROM @bookings_stage/uk_travel_bookings.csv; 


CREATE DATABASE IF NOT EXISTS travel_db;

CREATE DATABASE IF NOT EXISTS travel_db;
USE DATABASE travel_db;
USE SCHEMA public;


CREATE OR REPLACE FILE FORMAT csv_ff
  TYPE = CSV
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  NULL_IF = ('');

CREATE OR REPLACE STAGE bookings_stage FILE_FORMAT = csv_ff;

USE DATABASE travel_db;
USE SCHEMA public;

CREATE OR REPLACE STAGE bookings_stage FILE_FORMAT = csv_ff; 

COPY INTO travel_db.public.bookings 
FROM @travel_db.public.bookings_stage/uk_travel_bookings.csv;

Q1.
SELECT * FROM bookings LIMIT 10; 

Q2.
SELECT COUNT(*) AS total_bookings FROM bookings; 

Q3.
SELECT booking_id, customer_name, destination_city, travel_start_date
FROM bookings
WHERE destination_country = 'Spain';

Q4.
SELECT booking_id, customer_name, destination_city, status
FROM bookings
WHERE status = 'Cancelled';

Q5.
SELECT booking_id, customer_name, discount_pct
FROM bookings
WHERE discount_pct IS NULL;

Q6.
SELECT booking_id,
       travellers * price_per_person_gbp * (1 - COALESCE(discount_pct,0)/100) AS revenue_gbp
FROM bookings;

Q7.
SELECT package_type,
       ROUND(SUM(travellers * price_per_person_gbp * (1 - COALESCE(discount_pct,0)/100)), 2) AS revenue_gbp
FROM bookings
WHERE status <> 'Cancelled'
GROUP BY package_type
ORDER BY revenue_gbp DESC; 

Q8.
SELECT destination_country, COUNT(*) AS bookings
FROM bookings
GROUP BY destination_country
ORDER BY bookings DESC
LIMIT 1;

Q9.
SELECT payment_mode,
       COUNT(*) AS bookings,
       ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct_share
FROM bookings
GROUP BY payment_mode
ORDER BY bookings DESC; 

Q10.
SELECT customer_name, COUNT(*) AS bookings
FROM bookings
GROUP BY customer_name
HAVING COUNT(*) > 2; 

Q11.
SELECT destination_country,
       ROUND(AVG(rating), 2) AS avg_rating,
       COUNT(rating) AS rated_trips
FROM bookings
GROUP BY destination_country
HAVING COUNT(rating) >= 2
ORDER BY avg_rating DESC;

Q12.
SELECT booking_id, customer_name,
       DATEADD('day', nights, travel_start_date) AS return_date,
       DATEDIFF('day', booking_date, travel_start_date) AS lead_time_days
FROM bookings;

Q13.
SELECT DATE_TRUNC('month', travel_start_date) AS travel_month,
       COUNT(*) AS bookings,
       ROUND(SUM(travellers * price_per_person_gbp * (1 - COALESCE(discount_pct,0)/100)), 2) AS revenue_gbp
FROM bookings
WHERE status <> 'Cancelled'
GROUP BY travel_month
ORDER BY travel_month;

Q14.
SELECT home_city, customer_name, total_spend,
       RANK() OVER (PARTITION BY home_city ORDER BY total_spend DESC) AS city_rank
FROM (
  SELECT home_city, customer_name,
         SUM(travellers * price_per_person_gbp * (1 - COALESCE(discount_pct,0)/100)) AS total_spend
  FROM bookings
  WHERE status <> 'Cancelled'
  GROUP BY home_city, customer_name
);

Q15.
SELECT customer_name, booking_date,
       DATEDIFF('day',
         LAG(booking_date) OVER (PARTITION BY customer_id ORDER BY booking_date),
         booking_date) AS days_since_last_booking
FROM bookings
QUALIFY COUNT(*) OVER (PARTITION BY customer_id) > 1
ORDER BY customer_name, booking_date;

Q16.
SELECT package_type, destination_city,
       SUM(travellers * price_per_person_gbp) AS revenue_gbp
FROM bookings
WHERE status <> 'Cancelled'
GROUP BY package_type, destination_city
QUALIFY ROW_NUMBER() OVER (PARTITION BY package_type ORDER BY SUM(travellers * price_per_person_gbp) DESC) <= 2;

Q17.
SELECT package_type,
       COUNT(*) AS bookings,
       SUM(IFF(status = 'Cancelled', 1, 0)) AS cancelled,
       ROUND(100 * SUM(IFF(status = 'Cancelled', 1, 0)) / COUNT(*), 1) AS cancel_rate_pct
FROM bookings
GROUP BY package_type; 

Q18.
SELECT booking_id, destination_city, price_per_person_gbp,
       CASE
         WHEN price_per_person_gbp < 400 THEN 'Budget'
         WHEN price_per_person_gbp < 900 THEN 'Mid-range'
         ELSE 'Premium'
       END AS price_band
FROM bookings;


Q19.
DELETE FROM bookings WHERE status = 'Cancelled';
SELECT COUNT(*) FROM bookings;

-- Table as it was 5 minutes ago
SELECT COUNT(*) FROM bookings AT(OFFSET => -60*5);


-- Restore using the query ID of the DELETE (see Query History)
INSERT INTO bookings
SELECT * FROM bookings BEFORE(STATEMENT => '01c858d7-0309-63fe-0000-0005a1a64959')
WHERE status = 'Cancelled';

Q20.
CREATE TABLE bookings_dev CLONE bookings;
UPDATE bookings_dev SET status = 'Completed' WHERE status = 'Upcoming';


SELECT status, COUNT(*) FROM bookings GROUP BY status;
SELECT status, COUNT(*) FROM bookings_dev GROUP BY status; 

Q21.
DROP TABLE bookings_dev;
UNDROP TABLE bookings_dev;

Q22.
CREATE OR REPLACE TABLE booking_events (event VARIANT);


INSERT INTO booking_events
SELECT PARSE_JSON('{"booking_id":2001,"device":"mobile","extras":[{"name":"Airport Transfer","price":35},{"name":"Travel Insurance","price":22}]}');

SELECT event:booking_id::INT AS booking_id,
       event:device::STRING AS device,
       f.value:name::STRING AS extra_name,
       f.value:price::NUMBER AS extra_price_gbp
FROM booking_events,
     LATERAL FLATTEN(input => event:extras) f;


Q23.
CREATE OR REPLACE VIEW v_marketing_bookings AS
SELECT booking_id, home_city, destination_country, package_type,
       travel_start_date, travellers, status
FROM bookings;

Q24.
CREATE OR REPLACE MASKING POLICY mask_name AS (val STRING) RETURNS STRING ->
  CASE WHEN CURRENT_ROLE() IN ('ACCOUNTADMIN') THEN val ELSE '*** MASKED ***' END;


ALTER TABLE bookings MODIFY COLUMN customer_name SET MASKING POLICY mask_name;

Q25.
ALTER WAREHOUSE travel_wh SET WAREHOUSE_SIZE = 'MEDIUM';
-- run a heavy query
ALTER WAREHOUSE travel_wh SET WAREHOUSE_SIZE = 'XSMALL';








 
