-- Top 10 countries by 7-day incidence on a selected date
WITH x AS (
  SELECT
    date,
    country_name,
    population,
    new_confirmed,
    AVG(new_confirmed) OVER (
      PARTITION BY country_name
      ORDER BY date
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS new_7d
  FROM `charged-city-421819.covid.owid`
  WHERE population IS NOT NULL AND population > 0
)
SELECT
  country_name,
  ROUND(new_7d * 100000.0 / population, 2) AS new_per_100k_7d
FROM x
WHERE date = @target_date         --Parameter: @target_date (DATE), exp. '2021-12-01'
ORDER BY new_per_100k_7d DESC
LIMIT 10;