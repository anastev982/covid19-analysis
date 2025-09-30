-- Top 10 countries by 7-day incidence on a selected date
WITH base AS (
  SELECT
    date,
    location AS country_name,
    total_cases AS cumulative_confirmed,
    population
  FROM `charged-city-421819.covid.owid`
  WHERE population IS NOT NULL AND population > 0
    AND total_cases IS NOT NULL
),
daily AS (
  SELECT
    date, country_name, population,
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
    date, country_name, population,
    AVG(new_cases) OVER (
      PARTITION BY country_name
      ORDER BY date
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS new_7d
  FROM daily
)
SELECT
  country_name,
  ROUND(new_7d * 100000.0 / population, 2) AS new_per_100k_7d
FROM with_ma
WHERE date = @target_date
ORDER BY new_per_100k_7d DESC
LIMIT 10;