CREATE TABLE ssb.lineorder
(
    `LO_ORDERKEY` UInt32,
    `LO_LINENUMBER` UInt8,
    `LO_CUSTKEY` UInt32 CODEC(T64, LZ4),
    `LO_PARTKEY` UInt32 CODEC(T64, LZ4),
    `LO_SUPPKEY` UInt32 CODEC(T64, LZ4),
    `LO_ORDERDATE` Date CODEC(T64, LZ4),
    `LO_ORDERPRIORITY` LowCardinality(String) CODEC(ZSTD(1)),
    `LO_SHIPPRIORITY` UInt8,
    `LO_QUANTITY` UInt8 CODEC(ZSTD(1)),
    `LO_EXTENDEDPRICE` UInt32 CODEC(T64, LZ4),
    `LO_ORDTOTALPRICE` UInt32 CODEC(T64, LZ4),
    `LO_DISCOUNT` UInt8 CODEC(ZSTD(1)),
    `LO_REVENUE` UInt32 CODEC(T64, LZ4),
    `LO_SUPPLYCOST` UInt32 CODEC(T64, LZ4),
    `LO_TAX` UInt8 CODEC(ZSTD(1)),
    `LO_COMMITDATE` Date CODEC(T64, LZ4),
    `LO_SHIPMODE` LowCardinality(String) CODEC(ZSTD(1))
)
ENGINE = MergeTree()
PARTITION BY toYYYYMM(LO_ORDERDATE)
ORDER BY (LO_SUPPKEY, LO_ORDERDATE)
SETTINGS index_granularity = 8192;

CREATE TABLE ssb.customer
(
    `C_CUSTKEY` UInt32,
    `C_NAME` String,
    `C_ADDRESS` String,
    `C_CITY` LowCardinality(String),
    `C_NATION` LowCardinality(String),
    `C_REGION` LowCardinality(String),
    `C_PHONE` String,
    `C_MKTSEGMENT` LowCardinality(String)
)
ENGINE = MergeTree
ORDER BY C_CUSTKEY
SETTINGS index_granularity = 8192;

CREATE TABLE ssb.part
(
    `P_PARTKEY` UInt32,
    `P_NAME` String,
    `P_MFGR` LowCardinality(String),
    `P_CATEGORY` LowCardinality(String),
    `P_BRAND` LowCardinality(String),
    `P_COLOR` LowCardinality(String),
    `P_TYPE` LowCardinality(String),
    `P_SIZE` UInt8,
    `P_CONTAINER` LowCardinality(String)
)
ENGINE = MergeTree
ORDER BY P_PARTKEY
SETTINGS index_granularity = 8192;

CREATE TABLE ssb.supplier
(
    `S_SUPPKEY` UInt32,
    `S_NAME` String,
    `S_ADDRESS` String,
    `S_CITY` LowCardinality(String),
    `S_NATION` LowCardinality(String),
    `S_REGION` LowCardinality(String),
    `S_PHONE` String
)
ENGINE = MergeTree
ORDER BY S_SUPPKEY
SETTINGS index_granularity = 8192;