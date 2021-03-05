# Server specific
# CH_CLIENT=clickhouse-client
# CH_HOST=localhost
# CH_USER=default
# CH_PASS=
#
# can be run as: 
# CH_CLIENT=clickhouse-client CH_HOST=localhost CH_USER=default CH_PASS= ./bench.sh 

# Test specific
# CH_DB=ssb
# QUERIES_DIR=original/queries

# CH_CLIENT=clickhouse-client CH_HOST=localhost CH_USER=default CH_PASS= CH_DB=ssb QUERIES_DIR=original/queries ./bench.sh 


CUR_DIR=`pwd`

for i in `ls $QUERIES_DIR`
do
  echo $i
  time cat $CUR_DIR/$QUERIES_DIR/$i | $CH_CLIENT -h $CH_HOST --port 9440 -s --user=$CH_USER --password=$CH_PASS --database=$CH_DB
done