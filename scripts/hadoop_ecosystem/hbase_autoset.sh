cd /usr/local/hadoop_eco
wget http://apache.mirror.cdnetworks.com/hbase/stable/hbase-1.2.4-bin.tar.gz
tar zxvf hbase-1.2.4-bin.tar.gz
mv hbase-1.2.4 hbase

echo " " >> ~/.bashrc
echo "# HBase" >> ~/.bashrc
echo " " >> ~/.bashrc
echo "export HBASE_HOME=/usr/local/hadoop_eco/hbase" >> ~/.bashrc
echo "export HBASE_CLASSPATH=$HADOOP_CONF_DIR" >> ~/.bashrc
echo "export PATH=$PATH:$HBASE_HOME" >> ~/.bashrc
echo "export PATH=$PATH:$HBASE_HOME/bin" >> ~/.bashrc

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

echo " " >> $HBASE_HOME/conf/hbase-env.sh 
echo "export HBASE_PID_DIR=/usr/local/hadoop_var/hbase" >> $HBASE_HOME/conf/hbase-env.sh 
echo "export HBASE_MANAGES_ZK=false     " >> $HBASE_HOME/conf/hbase-env.sh 
echo "export HBASE_REGIONSERVERS=/usr/local/hadoop_eco/hbase/conf/regionservers" >> $HBASE_HOME/conf/hbase-env.sh 
echo "export JAVA_HOME=/usr/lib/jvm/java-7-oracle/jre" >> $HBASE_HOME/conf/hbase-env.sh 
echo "export HBASE_LOG_DIR=/usr/local/hadoop_log/hbase/logs" >> $HBASE_HOME/conf/hbase-env.sh 
echo " " >> $HBASE_HOME/conf/hbase-env.sh 

echo "hd0m2" >> $HBASE_HOME/conf/regionservers
echo "hd0s1" >> $HBASE_HOME/conf/regionservers
echo "hd0s2" >> $HBASE_HOME/conf/regionservers
echo "hd0s3" >> $HBASE_HOME/conf/regionservers
echo "hd0s4" >> $HBASE_HOME/conf/regionservers

echo "hd0m2" >> $HBASE_HOME/conf/backup-masters





                




