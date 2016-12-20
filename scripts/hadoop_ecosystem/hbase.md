[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)


# Set up ```HBase```

## Download & Install ```HBase```

```sh
cd /usr/local/hadoop_eco
wget http://apache.mirror.cdnetworks.com/hbase/stable/hbase-1.2.4-bin.tar.gz
tar zxvf hbase-1.2.4-bin.tar.gz
mv hbase-1.2.4 hbase
```
or make a ```link```:
```sh
ln -s hbase-1.2.4/ hbase
```

## ```.bashrc```
```sh
vi ~/.bashrc
```
```sh
# Hbase
export HBASE_HOME=/usr/local/hadoop_eco/hbase
export HBASE_CLASSPATH=$HADOOP_CONF_DIR
export PATH=$PATH:$HBASE_HOME
export PATH=$PATH:$HBASE_HOME/bin
```

## ```HBase``` Configuration

```sh
mkdir -p /usr/local/hadoop_dat/hbase/data
ssh dawkiny@hd0m2 "mkdir -p /usr/local/hadoop_dat/hbase/data"
ssh dawkiny@hd0s1 "mkdir -p /usr/local/hadoop_dat/hbase/data"
ssh dawkiny@hd0s2 "mkdir -p /usr/local/hadoop_dat/hbase/data"
ssh dawkiny@hd0s3 "mkdir -p /usr/local/hadoop_dat/hbase/data"
ssh dawkiny@hd0s4 "mkdir -p /usr/local/hadoop_dat/hbase/data"
```

```sh
mkdir -p /usr/local/hadoop_log/hbase/logs
ssh dawkiny@hd0m2 "mkdir -p /usr/local/hadoop_log/hbase/logs"
ssh dawkiny@hd0s1 "mkdir -p /usr/local/hadoop_log/hbase/logs"
ssh dawkiny@hd0s2 "mkdir -p /usr/local/hadoop_log/hbase/logs"
ssh dawkiny@hd0s3 "mkdir -p /usr/local/hadoop_log/hbase/logs"
ssh dawkiny@hd0s4 "mkdir -p /usr/local/hadoop_log/hbase/logs"
```


## Create Links

```sh
ln -s $HADOOP_HOME/etc/hadoop/hdfs-site.xml hdfs-site.xml
ln -s $HADOOP_HOME/etc/hadoop/core-site.xml core-site.xml
ln -s $HADOOP_HOME/etc/hadoop/yarn-site.xml yarn-site.xml
```
## Configure ```hbase-site.xml```

```sh
source ~/.bashrc
vi $HBASE_HOME/conf/hbase-site.xml 
```

```xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
        <property>
                <name>hbase.rootdir</name>
                <value>hdfs://hd0m1:9000/hbase</value>
                <description>The directory shared by RegionServers.
                </description>
        </property>
        <property>
                <name>hbase.master</name>
                <value>hd0m1:6000</value>
        </property>
        <property>
                <name>hbase.zookeeper.quorum</name>
                <value>hd0m1:2181,hd0m2:2181,hd0s1:2181,hd0s2:2181,hd0s3:2181,hd0s4:2181</value>
                <description>The directory shared by RegionServers.
                </description>
        </property>
        <property>
                <name>hbase.zookeeper.property.dataDir</name>
                <value>file:///usr/local/hadoop_dat/hbase/data</value>
                <description>Property from ZooKeeper's config zoo.cfg.
                The directory where the snapshot is stored.
                </description>
        </property>
        <property>
                <name>hbase.cluster.distributed</name>
                <value>true</value>
                <description>The mode the cluster will be in. Possible values are
                false: standalone and pseudo-distributed setups with managed Zookeeper
                true: fully-distributed with unmanaged Zookeeper Quorum (see hbase-env.sh)
                </description>
        </property>
        <property>
                <name>dfs.datanode.max.transfer.threads</name>
                <value>4096</value>
                <description>dfs.datanode.max.xcievers
                </description>
        </property>
</configuration>
```

## Configure ```hbase-env.sh```

```sh
vi $HBASE_HOME/conf/hbase-env.sh 
```



```sh
export HBASE_PID_DIR=/usr/local/hadoop_var/hbase
export HBASE_MANAGES_ZK=false                     
export HBASE_REGIONSERVERS=/usr/local/hadoop_eco/hbase/conf/regionservers
export JAVA_HOME=/usr/lib/jvm/java-7-oracle/jre
export HBASE_LOG_DIR=/usr/local/hadoop_log/hbase/logs
```

## Configure```regionservers```

```sh
vi $HBASE_HOME/conf/regionservers
```
```sh
hd0m2
hd0s1
hd0s2
hd0s3
hd0s4
```

## Configure ```backup servers```
```sh
vi $HBASE_HOME/conf/backup-masters
```
```sh
hd0m2
```

## Push to HBase Nodes
```sh
vi ~/push-all.sh
```

```sh
#----------------Push to Nodes---------------#

# Push .bashrc
scp -r ~/.bashrc dawkiny@hd0m2:~/
scp -r ~/.bashrc dawkiny@hd0s1:~/
scp -r ~/.bashrc dawkiny@hd0s2:~/
scp -r ~/.bashrc dawkiny@hd0s3:~/
scp -r ~/.bashrc dawkiny@hd0s4:~/

## Re-run .bashrc
source ~/.bashrc
ssh dawkiny@hd0m2 "source ~/.bashrc"
ssh dawkiny@hd0s1 "source ~/.bashrc"
ssh dawkiny@hd0s2 "source ~/.bashrc"
ssh dawkiny@hd0s3 "source ~/.bashrc"
ssh dawkiny@hd0s4 "source ~/.bashrc"


# Push Haddop Ecosystem Folder
scp -r /usr/local/hadoop_eco dawkiny@hd0m2:/usr/local/
scp -r /usr/local/hadoop_eco dawkiny@hd0s1:/usr/local/
scp -r /usr/local/hadoop_eco dawkiny@hd0s2:/usr/local/
scp -r /usr/local/hadoop_eco dawkiny@hd0s3:/usr/local/
scp -r /usr/local/hadoop_eco dawkiny@hd0s4:/usr/local/

```

Then
```sh
bash ~/push-all.sh
```



## Start ```HBase```

On ```HBase.Master```:
```sh
start-hbase.sh
```
Or
```sh
ssh dawkiny@hd0m1 "/usr/local/hadoop_eco/hbase/bin/start-hbase.sh"
```
In case you need to add hosts to known lists
```sh
yes
```

## Check ```HBase```
```sh
jps
hbase shell
```

## Access via WEB

* master : http://192.168.56.11:16010

* slave0 : http://192.168.56.12:16010
* slave1 : http://192.168.56.21:16030  
* slave2 : http://192.168.56.22:16030  
* slave3 : http://192.168.56.23:16030  
* slave4 : http://192.168.56.24:16030  


## Stop ```HBase```

On ```HBase.Master```:
```sh
stop-hbase.sh
```

In Case ```master.pid: No such file or directory```, ```start-hbase.sh``` again.



[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)
