SELECT 
    toYear(LO_ORDERDATE) AS year, 
    S_CITY, 
    P_BRAND, 
    SUM(LO_REVENUE - LO_SUPPLYCOST) AS profit
FROM lineorder
WHERE (C_REGION = 'AMERICA') AND (S_NATION = 'UNITED STATES') AND (P_CATEGORY = 'MFGR#14') AND ((year = 1997) OR (year = 1998))
GROUP BY 
    year, 
    S_CITY, 
    P_BRAND
ORDER BY 
    year ASC, 
    S_CITY ASC, 
    P_BRAND ASC 