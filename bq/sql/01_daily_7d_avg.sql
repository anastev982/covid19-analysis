-- 7-day average of new cases per one country
WITH base AS (
  SELECT
    date,
    country_name,
    new_confirmed AS new_cases
  FROM `charged-city-421819.covid.owid`
  WHERE country_name IS NOT NULL
    AND new_confirmed IS NOT NULL
)
SELECT
  date,
  country_name,
  new_cases,
  AVG(new_cases) OVER (
    PARTITION BY country_name
    ORDER BY date
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
  ) AS new_cases_7d_avg
FROM base
ORDER BY country_name, date;