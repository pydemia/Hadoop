#--------------Start all ----------------#


##########################################
# NameNode
##########################################

# HDFS
start-dfs.sh

# Yarn
start-yarn.sh

# MR History Server
mr-jobhistory-daemon.sh start historyserver

# Zookeeper
zkServer.sh start

# HBase
start-hbase.sh

# Sqoop
sqoop2-server start

# Kafka
kafka-server-start.sh server.properties

# Hive
#hiveserver2
hive --service hiveserver2 &



##########################################
# DataNode
##########################################

array=(hd0m2 hd0s1 hd0s2 hd0s3 hd0s4)

for i in "${array[@]}"

do
        # Zookeeper
        ssh dawkiny@$i "/usr/local/hadoop_eco/zookeeper/bin/zkServer.sh start" 

        # Kafka
        ssh dawkiny@$i "kafka-server-start.sh server.properties"

done
