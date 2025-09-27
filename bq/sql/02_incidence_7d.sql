-- New cases per 100k + 7-day average per 100k
WITH enriched AS (
  SELECT
    date,
    country_name,
    new_confirmed,
    population
  FROM `charged-city-421819.covid.owid`
  WHERE country_name IS NOT NULL
    AND new_confirmed IS NOT NULL
    AND population IS NOT NULL AND population > 0
)
SELECT
  date,
  country_name,
  new_confirmed,
  ROUND(new_confirmed * 100000.0 / population, 2) AS new_per_100k,
  ROUND(
    AVG(new_confirmed) OVER (
      PARTITION BY country_name
      ORDER BY date
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) * 100000.0 / population, 2
  ) AS new_per_100k_7d_avg
FROM enriched
ORDER BY country_name, date;