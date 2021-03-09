CREATE TABLE lineorder_wide
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
    `C_MKTSEGMENT` LowCardinality(String),
    `S_SUPPKEY` UInt32,
    `S_NAME` LowCardinality(String),
    `S_ADDRESS` LowCardinality(String),
    `S_CITY` LowCardinality(String),
    `S_NATION` String,
    `S_REGION` Enum8('ASIA' = 0, 'AMERICA' = 1, 'AFRICA' = 2, 'EUROPE' = 3, 'MIDDLE EAST' = 4),
    `S_PHONE` LowCardinality(String),
    `P_PARTKEY` UInt32,
    `P_NAME` LowCardinality(String),
    `P_MFGR` Enum8('MFGR#2' = 0, 'MFGR#4' = 1, 'MFGR#5' = 2, 'MFGR#3' = 3, 'MFGR#1' = 4),
    `P_CATEGORY` String,
    `P_BRAND` LowCardinality(String),
    `P_COLOR` LowCardinality(String),
    `P_TYPE` LowCardinality(String),
    `P_SIZE` UInt8,
    `P_CONTAINER` LowCardinality(String)
)
ENGINE = MergeTree()
PARTITION BY toYYYYMM(LO_ORDERDATE)
PRIMARY KEY (S_REGION, C_REGION, P_MFGR, S_NATION, C_NATION, P_CATEGORY)
ORDER BY    (S_REGION, C_REGION, P_MFGR, S_NATION, C_NATION, P_CATEGORY, LO_CUSTKEY, LO_SUPPKEY)
SETTINGS index_granularity = 8192
;

SET min_insert_block_size_bytes = '1G', min_insert_block_size_rows = 1048576, max_insert_threads = 16, max_threads = 16;

INSERT INTO lineorder_wide
SELECT * 
  FROM lineorder LO
  LEFT OUTER JOIN customer C ON (C_CUSTKEY = LO_CUSTKEY)
  LEFT OUTER JOIN supplier S ON (S_SUPPKEY = LO_SUPPKEY)
  LEFT OUTER JOIN part P ON (P_PARTKEY = LO_PARTKEY)
;

