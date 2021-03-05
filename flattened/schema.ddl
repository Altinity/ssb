CREATE TABLE ssb.lineorder_wide
(
    `LO_ORDERKEY` UInt32,
    `LO_LINENUMBER` UInt8,
    `LO_CUSTKEY` UInt32,
    `LO_PARTKEY` UInt32,
    `LO_SUPPKEY` UInt32,
    `LO_ORDERDATE` Date,
    `LO_ORDERPRIORITY` LowCardinality(String),
    `LO_SHIPPRIORITY` UInt8,
    `LO_QUANTITY` UInt8,
    `LO_EXTENDEDPRICE` UInt32,
    `LO_ORDTOTALPRICE` UInt32,
    `LO_DISCOUNT` UInt8,
    `LO_REVENUE` UInt32,
    `LO_SUPPLYCOST` UInt32,
    `LO_TAX` UInt8,
    `LO_COMMITDATE` Date,
    `LO_SHIPMODE` LowCardinality(String),
    `C_CUSTKEY` UInt32,
    `C_NAME` String,
    `C_ADDRESS` String,
    `C_CITY` LowCardinality(String),
    `C_NATION` LowCardinality(String),
    `C_REGION` Enum8('ASIA' = 0, 'AMERICA' = 1, 'AFRICA' = 2, 'EUROPE' = 3, 'MIDDLE EAST' = 4),
    `C_PHONE` String,
    `C_MKTSEGMENT` String,
    `S_SUPPKEY` UInt32,
    `S_NAME` String,
    `S_ADDRESS` String,
    `S_CITY` LowCardinality(String),
    `S_NATION` LowCardinality(String),
    `S_REGION` Enum8('ASIA' = 0, 'AMERICA' = 1, 'AFRICA' = 2, 'EUROPE' = 3, 'MIDDLE EAST' = 4),
    `S_PHONE` String,
    `P_PARTKEY` UInt32,
    `P_NAME` String,
    `P_MFGR` Enum8('MFGR#2' = 0, 'MFGR#4' = 1, 'MFGR#5' = 2, 'MFGR#3' = 3, 'MFGR#1' = 4),
    `P_CATEGORY` LowCardinality(String),
    `P_BRAND` LowCardinality(String),
    `P_COLOR` String,
    `P_TYPE` String,
    `P_SIZE` UInt8,
    `P_CONTAINER` String
)
ENGINE = MergeTree()
PARTITION BY toYear(LO_ORDERDATE)
PRIMARY KEY (S_REGION, C_REGION, P_MFGR, S_NATION, C_NATION, P_CATEGORY)
ORDER BY (S_REGION, C_REGION, P_MFGR, S_NATION, C_NATION, P_CATEGORY, LO_CUSTKEY, LO_SUPPKEY)
SETTINGS index_granularity = 8192;

 ALTER TABLE ssb.lineorder_wide ADD INDEX s_city S_CITY TYPE set(0) GRANULARITY 35;
 ALTER TABLE ssb.lineorder_wide ADD INDEX c_city C_CITY TYPE set(0) GRANULARITY 7;
 ALTER TABLE ssb.lineorder_wide ADD INDEX p_brand P_BRAND TYPE minmax GRANULARITY 4;