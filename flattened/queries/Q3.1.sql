SELECT
  C_NATION,
  S_NATION,
 toYear(LO_ORDERDATE) AS year,
   SUM(LO_REVENUE) AS revenue
FROM lineorder
WHERE  C_REGION = 'ASIA'
  AND S_REGION = 'ASIA'
  AND year  >= 1992
  AND year  <= 1997
GROUP BY
  C_NATION,
  S_NATION,
  year
ORDER BY
  year ASC,
  revenue DESC