SELECT 
    sum(LO_REVENUE), 
    toYear(LO_ORDERDATE) AS year, 
    P_BRAND
FROM lineorder
WHERE (P_BRAND >= 'MFGR#2221') AND (P_BRAND <= 'MFGR#2228') AND (S_REGION = 'ASIA')
GROUP BY 
    year, 
    P_BRAND
ORDER BY 
    year ASC, 
    P_BRAND ASC