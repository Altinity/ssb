ALTER TABLE lineorder_wide add INDEX p_brand P_BRAND TYPE minmax GRANULARITY 4;  
ALTER TABLE lineorder_wide MATERIALIZE INDEX p_brand;  
ALTER TABLE lineorder_wide add INDEX s_city S_CITY TYPE set(0) GRANULARITY 35;
ALTER TABLE lineorder_wide MATERIALIZE INDEX s_city;
ALTER TABLE lineorder_wide add INDEX c_city C_CITY TYPE set(0) GRANULARITY 7;
ALTER TABLE lineorder_wide MATERIALIZE INDEX c_city;