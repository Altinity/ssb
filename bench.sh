#!/bin/bash

# Server specific
# CH_CLIENT=clickhouse-client
# CH_HOST=localhost
# CH_USER=default
# CH_PASS=

# Test specific
# CH_DB=ssb
# QUERIES_DIR=original/queries
# TRIES=1

# Usage:
#
# TRIES=3 CH_CLIENT=clickhouse-client CH_HOST=localhost CH_USER=default CH_PASS= CH_DB=ssb QUERIES_DIR=original/queries ./bench.sh 
#

CUR_DIR=`pwd`
TESTRUN=`date | md5sum`
echo "TESTRUN: $TESTRUN"

for i in `ls $QUERIES_DIR`
do
  echo $i
  TEST=`cat $CUR_DIR/$QUERIES_DIR/$i`
  TESTID="$TESTRUN/$i"
  for t in `seq 1 $TRIES`
  do
    TESTTRY="$TESTID/$t"
    echo "/* $TESTTRY */ $TEST" | $CH_CLIENT -h $CH_HOST --port 9440 -s --user=$CH_USER --password=$CH_PASS --database=$CH_DB --log_queries=1 > /dev/null
    $CH_CLIENT -h $CH_HOST --port 9440 -s --user=$CH_USER --password=$CH_PASS --database=$CH_DB --log_queries=0 --multiquery \
       --query="SYSTEM FLUSH LOGS; SELECT round(sum(query_duration_ms)/1000,3) FROM system.query_log where event_date=today() and type='QueryFinish' and query like '%$TESTTRY%';"
  done
  $CH_CLIENT -h $CH_HOST --port 9440 -s --user=$CH_USER --password=$CH_PASS --database=$CH_DB --log_queries=0 \
    --query="SELECT '$i avg:', round(sum(query_duration_ms)/1000/$TRIES,3) FROM system.query_log where event_date=today() and type='QueryFinish' and query like '%$TESTID%'"
done

$CH_CLIENT -h $CH_HOST --port 9440 -s --user=$CH_USER --password=$CH_PASS --database=$CH_DB --log_queries=0 \
  --query="SELECT extract(query, '$TESTRUN/(Q\\d.\\d)') Q, \
           round(min(query_duration_ms)/1000,3) min_t, \
           round(max(query_duration_ms)/1000,3) max_t, \
           round(avg(query_duration_ms)/1000,3) avg_t \
           FROM system.query_log where event_date=today() and type='QueryFinish' and query like '%$TESTRUN%' group by Q ORDER BY Q FORMAT TSVWithNames"

echo "Sum of avg query time:"
$CH_CLIENT -h $CH_HOST --port 9440 -s --user=$CH_USER --password=$CH_PASS --database=$CH_DB --log_queries=0 \
  --query="SELECT round(sum(query_duration_ms)/1000/$TRIES,3) FROM system.query_log where event_date=today() and type='QueryFinish' and query like '%$TESTRUN%'"
