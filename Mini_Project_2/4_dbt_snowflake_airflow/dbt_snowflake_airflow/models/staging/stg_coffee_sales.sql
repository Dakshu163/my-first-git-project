WITH source_data AS (
    SELECT *
    FROM {{ source('raw', 'coffee_sales') }}
),
cleaned AS (
   SELECT
        DATE AS sale_date,
        DATETIME AS sale_time,
        LOWER(TRIM(CASH_TYPE)) AS cash_type,
        CARD AS card_number,
        MONEY::NUMBER(10,2) AS amount,
        TRIM(COFFEE_NAME) AS coffee_name

    FROM source_data
)
SELECT *
FROM cleaned