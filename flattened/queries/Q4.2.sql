SELECT 
    toYear(LO_ORDERDATE) AS year, 
    S_NATION, 
    P_CATEGORY, 
    SUM(LO_REVENUE - LO_SUPPLYCOST) AS profit
FROM lineorder_wide
WHERE (C_REGION = 'AMERICA') AND (S_REGION = 'AMERICA') AND ((P_MFGR = 'MFGR#1') OR (P_MFGR = 'MFGR#2')) AND ((year = 1997) OR (year = 1998))
GROUP BY 
    year, 
    S_NATION, 
    P_CATEGORY
ORDER BY 
    year ASC, 
    S_NATION ASC, 
    P_CATEGORY ASC