COVID-19 Analysis – BigQuery Extension

Dataset:
I used the public dataset bigquery-public-data.covid19_open_data.covid19_open_data, which contains daily country-level information (confirmed cases, deaths, population, continent, etc.).

Goals:

Show how to analyze a large public dataset using BigQuery (SQL).
Practice queries such as GROUP BY, WINDOW functions and RANK.
Build a small Looker Studio dashboard connected directly to BigQuery.

Queries:

01_daily_7d_avg.sql → calculates 7-day moving average of new cases.
02_incidence_7d.sql → new cases per 100k population, with 7-day average.
03_top10_incidence.sql → top 10 countries by incidence on a given date.
04_peak_date.sql → peak 7-day incidence and date per country.

Dashboard:

I created a Looker Studio dashboard with:
Line chart (7-day average of new cases by country)
Bar chart (top 10 countries by incidence)
Scorecard (global totals of cases and deaths)

Repository structure (simplified):

notebooks/ → my original local analysis in Pandas and Spark
bq/sql/ → BigQuery queries
bq/dashboards/ → Looker dashboard link
bq/README_BQ.md → this file

Key takeaways:

Learned SQL on cloud datasets (BigQuery).
Used window functions, aggregations and ranking.
Connected BigQuery to Looker Studio for visualization.
Extended my existing COVID-19 project to a cloud/SQL version.