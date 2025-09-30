-- New cases per 100k + 7-day average per 100k
WITH base AS (
  SELECT
    date,
    location AS country_name,
    total_cases AS cumulative_confirmed,
    population
  FROM `charged-city-421819.covid.owid`
  WHERE location IN ('Serbia','Norway','Germany')
    AND population IS NOT NULL AND population > 0
    AND total_cases IS NOT NULL
    AND date BETWEEN DATE('2020-03-01') AND DATE('2022-12-31')
),
daily AS (
  SELECT
    date,
    country_name,
    population,
    GREATEST(
      COALESCE(
        cumulative_confirmed -
        LAG(cumulative_confirmed) OVER (PARTITION BY country_name ORDER BY date),
        0
      ),
      0
    ) AS new_cases
  FROM base
)
SELECT
  date,
  country_name,
  ROUND(new_cases * 100000.0 / population, 3) AS new_per_100k,
  ROUND(
    AVG(new_cases) OVER (
      PARTITION BY country_name
      ORDER BY date
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) * 100000.0 / population, 3
  ) AS new_per_100k_7d_avg
FROM daily
ORDER BY country_name, date;
