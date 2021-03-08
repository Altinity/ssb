SELECT 
    SUM(LO_REVENUE), 
    toYear(LO_ORDERDATE) AS year, 
    P_BRAND
FROM lineorder_wide
WHERE (P_BRAND = 'MFGR#2221') AND (S_REGION = 'EUROPE')
GROUP BY 
    year, 
    P_BRAND
ORDER BY 
    year ASC, 
    P_BRAND ASC