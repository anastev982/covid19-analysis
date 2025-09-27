-- Peak 7-day average and peak date per country
WITH x AS (
  SELECT
    date, country_name, population, new_confirmed,
    AVG(new_confirmed) OVER (
      PARTITION BY country_name
      ORDER BY date
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS new_7d
  FROM `charged-city-421819.covid.owid`
  WHERE population IS NOT NULL AND population > 0
),
ranked AS (
  SELECT
    country_name,
    date,
    new_7d,
    DENSE_RANK() OVER (PARTITION BY country_name ORDER BY new_7d DESC) AS rnk
  FROM x
)
SELECT country_name, date AS peak_date, ROUND(new_7d,2) AS peak_new_7d
FROM ranked
WHERE rnk = 1
ORDER BY peak_new_7d DESC;