from google.cloud import bigquery
import pandas as pd
import os
from datetime import date

PROJECT_ID = os.getenv("GOOGLE_CLOUD_PROJECT", "your-project-id")  # ← promeni
client = bigquery.Client(project=PROJECT_ID)

ROOT = os.path.dirname(__file__)
SQL_DIR = os.path.join(ROOT, "sql")
OUT_DIR = os.path.join(ROOT, "..", "outputs")
os.makedirs(OUT_DIR, exist_ok=True)

def run_sql_to_csv(filename, params=None, out_csv=None):
    with open(os.path.join(SQL_DIR, filename), "r", encoding="utf-8") as f:
        query = f.read()
    job_config = bigquery.QueryJobConfig()
    if params:
        job_config.query_parameters = params
    df = client.query(query, job_config=job_config).result().to_dataframe()
    out_path = os.path.join(OUT_DIR, out_csv or filename.replace(".sql", ".csv"))
    df.to_csv(out_path, index=False)
    print(f"Saved {out_path} ({len(df)} rows)")

if __name__ == "__main__":
    run_sql_to_csv("01_daily_7d_avg.sql")
    run_sql_to_csv("02_incidence_7d.sql")
    run_sql_to_csv(
        "03_top10_incidence.sql",
        params=[bigquery.ScalarQueryParameter("target_date", "DATE", date(2021,12,1))],
        out_csv="top10_incidence_2021-12-01.csv"
    )
    run_sql_to_csv("04_peak_date.sql")