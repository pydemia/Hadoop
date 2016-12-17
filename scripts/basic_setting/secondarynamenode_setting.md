# Hadoop Setting - 3.SecondaryNameNode


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

### Create Folders in SecondaryNameNode
```sh
sudo mkdir -p /usr/local/hadoop_work/hdfs/yarn/local
sudo mkdir -p /usr/local/hadoop_work/hdfs/yarn/log

sudo chown -R [user]:hadoop /usr/local/hadoop
sudo chown -R [user]:hadoop /usr/local/hadoop_work
```
