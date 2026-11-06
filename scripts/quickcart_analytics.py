import os
import re
import numpy as np
import pandas as pd

# ============================================================================
# Q1. DATA INGESTION PIPELINE
# ============================================================================


def ingest_data(base_path="."):
  """Reads QuickCart CSV files safely into DataFrames."""
  files = {
      "customers": "customers.csv",
      "orders": "orders.csv",
      "products": "products.csv",
      "clickstream": "clickstream.csv",
  }
  dfs = {}
  for key, filename in files.items():
    file_path = os.path.join(base_path, filename)
    if os.path.exists(file_path):
      dfs[key] = pd.read_csv(file_path)
      print(f"Successfully loaded {key} with shape {dfs[key].shape}")
    else:
      print(f"Warning: File {filename} not found.")
  return dfs


def validate_schema(dfs):
  """Validates required columns across all loaded datasets."""
  expected_schemas = {
      "customers": ["customer_id", "customer_name", "email", "city", "signup_date"],
      "orders": [
          "order_id",
          "customer_id",
          "product_id",
          "order_date",
          "quantity",
          "unit_price",
          "payment_status",
      ],
      "products": [
          "product_id",
          "product_name",
          "category",
          "supplier_id",
          "cost_price",
          "selling_price",
      ],
      "clickstream": [
          "event_id",
          "customer_id",
          "event_type",
          "page_url",
          "event_timestamp",
          "device_type",
      ],
  }

  for name, expected_cols in expected_schemas.items():
    if name in dfs:
      actual_cols = set(dfs[name].columns)
      missing = set(expected_cols) - actual_cols
      if missing:
        print(f"Schema Error in {name}: Missing columns {missing}")
      else:
        print(f"Schema Validation Passed for {name}")


def detect_duplicates_and_invalids(dfs):
  """Identifies duplicate customers and invalid order rows."""
  if "customers" in dfs:
    cust_df = dfs["customers"]
    dups_id = cust_df[cust_df.duplicated(subset=["customer_id"], keep=False)]
    dups_email = cust_df[cust_df.duplicated(subset=["email"], keep=False)]
    print(f"Duplicate Customer IDs found: {len(dups_id)}")
    print(f"Duplicate Emails found: {len(dups_email)}")

  if "orders" in dfs:
    orders_df = dfs["orders"]
    invalid_orders = orders_df[
        (orders_df["quantity"] <= 0) | (orders_df["unit_price"] < 0)
    ]
    print(f"Invalid Order Records found: {len(invalid_orders)}")


# ============================================================================
# Q2. DATA CLEANING & TRANSFORMATION
# ============================================================================


def clean_transform_data(dfs):
  """Cleans and standardizes all QuickCart DataFrames."""
  cleaned_dfs = {}

  # Clean Customers
  if "customers" in dfs:
    df_c = dfs["customers"].drop_duplicates(subset=["customer_id"]).copy()
    # Standardize city names
    df_c["city"] = df_c["city"].astype(str).str.strip().str.title()
    # Standardize dates
    df_c["signup_date"] = pd.to_datetime(df_c["signup_date"], errors="coerce")
    # Handle missing emails
    df_c["email"] = df_c["email"].fillna("unknown@quickcart.com")
    cleaned_dfs["customers"] = df_c.dropna(subset=["customer_id"])

  # Clean Orders
  if "orders" in dfs:
    df_o = dfs["orders"].copy()
    df_o["order_date"] = pd.to_datetime(df_o["order_date"], errors="coerce")
    # Remove corrupted/invalid rows
    df_o = df_o[
        (df_o["quantity"] > 0)
        & (df_o["unit_price"] >= 0)
        & (df_o["order_id"].notnull())
    ]
    cleaned_dfs["orders"] = df_o

  # Clean Clickstream
  if "clickstream" in dfs:
    df_clk = dfs["clickstream"].copy()
    df_clk["event_timestamp"] = pd.to_datetime(
        df_clk["event_timestamp"], errors="coerce"
    )
    df_clk["device_type"] = (
        df_clk["device_type"].astype(str).str.strip().str.lower()
    )
    cleaned_dfs["clickstream"] = df_clk.dropna(subset=["event_id"])

  return cleaned_dfs


# ============================================================================
# Q3. CLICKSTREAM ANALYTICS
# ============================================================================


def analyze_clickstream(clickstream_df):
  """Performs web behavior and device analysis on clickstream data."""
  print("\n--- Clickstream Analysis Results ---")

  # 1. Top visited pages
  top_pages = (
      clickstream_df["page_url"]
      .value_counts()
      .head(5)
      .reset_index(name="visit_count")
  )
  print("\nTop Visited Pages:\n", top_pages)

  # 2. Estimate session counts (Inactivity threshold: 30 mins per customer)
  df_sorted = clickstream_df.sort_values(
      by=["customer_id", "event_timestamp"]
  ).copy()
  df_sorted["time_diff"] = (
      df_sorted.groupby("customer_id")["event_timestamp"].diff().dt.total_seconds()
  )
  # Mark new session if time difference > 1800s (30 mins) or if first customer event
  df_sorted["new_session"] = (df_sorted["time_diff"] > 1800) | (
      df_sorted["time_diff"].isnull()
  )
  df_sorted["session_id"] = df_sorted.groupby("customer_id")[
      "new_session"
  ].cumsum()

  total_sessions = df_sorted.groupby(["customer_id", "session_id"]).ngroups
  print(f"\nTotal Estimated Customer Sessions: {total_sessions}")

  # 3. Mobile vs Desktop Traffic Percentage
  device_counts = clickstream_df["device_type"].value_counts(normalize=True) * 100
  print("\nTraffic Breakdown by Device Type (%):\n", device_counts.round(2))


if __name__ == "__main__":
  # Run ingestion & processing
  datasets = ingest_data()
  validate_schema(datasets)
  detect_duplicates_and_invalids(datasets)
  cleaned_data = clean_transform_data(datasets)

  if "clickstream" in cleaned_data:
    analyze_clickstream(cleaned_data["clickstream"]) 



    