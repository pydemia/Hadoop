
## Confiture ```hdfs-site.xml```

```sh
vi hdfs-site.xml
```

add This: 
```xml
    <property>
    <name>dfs.secondary.http.address</name>
    <value>hd0m2:50090</value>
    </property>
```

## Install Hadoop Distribution From NameNode

### Copy Hadoop From NameNode to SecondaryNameNode

From SecondaryNameNode

```sh
cd /usr/local
sudo scp -r [username]@hd0m1:/usr/local/hadoop /usr/local
```

### Create Folders in Each DataNode
```sh
sudo mkdir -p /usr/local/hadoop_work/hdfs/datanode
sudo mkdir -p /usr/local/hadoop_work/hdfs/yarn/local
sudo mkdir -p /usr/local/hadoop_work/hdfs/yarn/log

sudo chown -R [user]:hadoop /usr/local/hadoop
sudo chown -R [user]:hadoop /usr/local/hadoop_work
```

# Start HDFS

```sh
start-dfs.sh
```

# Create HDFS directories(/tmp, /user, /usr/app, /var/log/hadoop-yarn, /var/log/hadoop-yarn/apps

```sh
hdfs fs -mkdir /tmp
hdfs fs -mkdir -p /user/app
hdfs fs -mkdir -p /var/log/hadoop-yarn/apps


hdfs fs -chmod -R 1777 /tmp
hdfs fs -chmod -R 1777 /user
hdfs fs -chmod -R 1777 /var/log/hadoop-yarn
```

Check it:
```sh
hdfs fs -ls -R /
```

# Start YARN Cluster

```sh
start-yarn.sh
```

# Start MR History Server

```sh
mr-jobhistory-daemon.sh start historyserver
```


# Check Daemons

```sh
jps
```

From NameNode:
>NameNode
>ResourceManager
>JobHistoryServer
>Jps

From SecondaryNameNode:
>SecondaryNameNode
>Jps

From Each DataNode:
>DataNode
>NodeManager
>Jps


# Test HDFS by Uploading Files

## On Linux
```sh
mkdir ~/test
echo -p "This, is, dummy, file" > ~/test/test_dummy.csv 
```


## on HDFS

```sh
hdfs dfs -put ~/test /

hdfs dfs -ls -R /
hdfs dfs -cat /test/test_dummy.csv

hdfs dfs -rm -r /test
```

# Show HDFS on Browser

## NameNode
http://192.168.56.11:50070/

## HDFS
http://192.168.56.11:50070/explorer.html

## Resource Manager
http://192.168.56.11:8088/

## History Server
http://192.168.56.11:19888/


