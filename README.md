COVID-19 Trends — Serbia, Norway, Germany (Portfolio)

A short, clean, and reproducible analysis of COVID-19 trends for Serbia, Norway, and Germany.
Data are fetched directly from the Our World in Data (OWID) GitHub URL — no local file required.

Why this is useful:
Per-million normalization + 7-day moving average (MA7) and weekly aggregation make cross-country comparisons clearer and reduce daily noise.

 What this project does

Fetch from OWID URL (no manual download)
Per-million normalization and MA7 smoothing — clearer trends
Weekly aggregation (resample) — less noise
Identify peaks (local maxima on MA7 per-million)

Optional extras:

CFR with lag (≈ deaths / cases(−14d))
Rt-ish (MA7 / MA7(−7d))
Lagged correlation between vaccination and deaths (+21 days)

 Repository structure
.
├── COVID19-Portfolio.ipynb      # OWID local analysis (Python/Pandas)
├── requirements.txt
├── outputs/
│   └── plots/                   # exported figures
├── bq/                          # BigQuery extension (SQL + dashboard)
│   ├── sql/
│   ├── dashboards/
│   └── README_BQ.md
└── README.md

 Part 1 – Local analysis (Python, Pandas, Spark)

Loaded and cleaned COVID-19 datasets (OWID).
Used Pandas and Dask for wrangling.
Performed exploratory analysis (EDA).
Built ML experiments (prediction tasks).
Visualized results with Matplotlib and Seaborn.

 Part 2 – BigQuery extension

Dataset: bigquery-public-data.covid19_open_data.covid19_open_data
Queries include:
7-day moving averages of new cases
Incidence per 100k population
Top 10 countries by incidence (selected dates)
Peak incidence date per country

Looker Studio dashboard:

Line chart (7-day avg by country)
Bar chart (top 10 by incidence)
Scorecards (global totals)

 Link to the BigQuery module

 Option B: 
 I also import OWID into my own table covid.owid and query from there.

 Key learnings

Hands-on practice with large datasets both locally and in the cloud.
SQL in BigQuery with window functions, aggregations, and ranking.
Extended an existing project to demonstrate both data analysis and data engineering/cloud skills.
Connected BigQuery → Looker Studio for simple dashboards.