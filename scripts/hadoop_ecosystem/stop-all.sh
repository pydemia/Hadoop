#--------------Stop all ----------------#


##########################################
# NameNode
##########################################

# HDFS
stop-dfs.sh

# Yarn
sttop-yarn.sh

# MR History Server
mr-jobhistory-daemon.sh stop historyserver

# Zookeeper
zkServer.sh stop

# HBase
stop-hbase.sh

# Sqoop
sqoop2-server stop

# Kafka
kafka-server-stop.sh



##########################################
# DataNode
##########################################

array=(hd0m2 hd0s1 hd0s2 hd0s3 hd0s4)

for i in "${array[@]}"

do
        # Zookeeper
        ssh dawkiny@$i "/usr/local/hadoop_eco/zookeeper/bin/zkServer.sh stop" 

        # Kafka
        ssh dawkiny@$i "kafka-server-stop.sh"

done
