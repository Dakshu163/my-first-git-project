from snowflake.snowpark import Session
from snowflake.snowpark.functions import col, sum as sum_, round as round_

connection_parameters = {
    "account": "dcuyndn-hj87912",
    "user": "YOUR_USERNAME",
    "password": "YOUR_PASSWORD",
    "role": "ACCOUNTADMIN",
    "warehouse": "COMPUTE_WH",
    "database": "BREWBEATS_DB",
    "schema": "PUBLIC"
}

session = Session.builder.configs(connection_parameters).create()

df = session.table("coffee_sales")
top_3_coffees = (
    df.group_by("coffee_name")
      .agg(round_(sum_("money"), 2).alias("revenue"))
      .sort(col("revenue").desc())
      .limit(3)
)

top_3_coffees.show()
session.close()