cd /usr/local/hadoop_eco
wget http://apache.mirror.cdnetworks.com/hbase/stable/hbase-1.2.4-bin.tar.gz
tar zxvf hbase-1.2.4-bin.tar.gz
mv hbase-1.2.4 hbase

mkdir -p /usr/local/hadoop_dat/hbase/data
ssh dawkiny@hd0m2 "mkdir -p /usr/local/hadoop_dat/hbase/data"
ssh dawkiny@hd0s1 "mkdir -p /usr/local/hadoop_dat/hbase/data"
ssh dawkiny@hd0s2 "mkdir -p /usr/local/hadoop_dat/hbase/data"
ssh dawkiny@hd0s3 "mkdir -p /usr/local/hadoop_dat/hbase/data"
ssh dawkiny@hd0s4 "mkdir -p /usr/local/hadoop_dat/hbase/data"

mkdir -p /usr/local/hadoop_log/hbase/logs
ssh dawkiny@hd0m2 "mkdir -p /usr/local/hadoop_log/hbase/logs"
ssh dawkiny@hd0s1 "mkdir -p /usr/local/hadoop_log/hbase/logs"
ssh dawkiny@hd0s2 "mkdir -p /usr/local/hadoop_log/hbase/logs"
ssh dawkiny@hd0s3 "mkdir -p /usr/local/hadoop_log/hbase/logs"
ssh dawkiny@hd0s4 "mkdir -p /usr/local/hadoop_log/hbase/logs"

ln -s $HADOOP_HOME/etc/hadoop/hdfs-site.xml hdfs-site.xml
ln -s $HADOOP_HOME/etc/hadoop/core-site.xml core-site.xml
ln -s $HADOOP_HOME/etc/hadoop/yarn-site.xml yarn-site.xml


source ~/.bashrc




