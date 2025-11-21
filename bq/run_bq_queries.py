# bq/run_bq_queries.py
from google.cloud import bigquery
from pathlib import Path
from datetime import date

# Project & location
PROJECT_ID = "charged-city-421819"
LOCATION = "EU"  # dataset / work is in EU

client = bigquery.Client(project=PROJECT_ID)

ROOT = Path(__file__).resolve().parent
SQL_DIR = ROOT / "sql"
OUT_DIR = ROOT.parent / "outputs"
OUT_DIR.mkdir(parents=True, exist_ok=True)

def run_sql_to_csv(sql_filename: str, out_csv: str, params=None):
    query = (SQL_DIR / sql_filename).read_text(encoding="utf-8")
    job_config = bigquery.QueryJobConfig()
    if params:
        job_config.query_parameters = params
    df = client.query(query, job_config=job_config, location=LOCATION).result().to_dataframe()
    df.to_csv(OUT_DIR / out_csv, index=False)
    print(f"Saved {OUT_DIR / out_csv} ({len(df)} rows)")
    return df

if __name__ == "__main__":
    # 01
    run_sql_to_csv("01_daily_7d_avg.sql", "daily_7d_avg.csv")
    # 02
    run_sql_to_csv("02_incidence_7d.sql", "incidence_7d.csv")
    # 03 (parameterized date)
    params = [bigquery.ScalarQueryParameter("target_date", "DATE", date(2021, 12, 1))]
    run_sql_to_csv("03_top10_incidence.sql", "top10_incidence_2021-12-01.csv", params=params)
    # 04
    run_sql_to_csv("04_peak_date.sql", "peak_dates.csv")