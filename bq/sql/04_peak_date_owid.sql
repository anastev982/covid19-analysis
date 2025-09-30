-- Peak 7-day average and peak date per country
WITH base AS (
  SELECT
    date,
    location AS country_name,
    total_cases AS cumulative_confirmed,
    population
  FROM `charged-city-421819.covid.owid`
  WHERE population IS NOT NULL AND population > 0
    AND total_cases IS NOT NULL
    -- if you want *only* 3 countries here, use location (not alias):
    -- AND location IN ('Serbia','Norway','Germany')
),
daily AS (
  SELECT
    date,
    country_name,
    GREATEST(
      COALESCE(
        cumulative_confirmed -
        LAG(cumulative_confirmed) OVER (PARTITION BY country_name ORDER BY date),
        0
      ),
      0
    ) AS new_cases
  FROM base
),
with_ma AS (
  SELECT
    date,
    country_name,
    AVG(new_cases) OVER (
      PARTITION BY country_name
      ORDER BY date
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS new_7d
  FROM daily
),
ranked AS (
  SELECT
    country_name,
    date,
    new_7d,
    DENSE_RANK() OVER (PARTITION BY country_name ORDER BY new_7d DESC) AS rnk
  FROM with_ma
)
SELECT
  country_name,
  date AS peak_date,
  ROUND(new_7d, 2) AS peak_new_7d
FROM ranked
WHERE rnk = 1
ORDER BY peak_new_7d DESC;