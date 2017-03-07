[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)



# Easy Install

## SU Password
```sh
sudo passwd root
```
## Create Group for HADOOP User

```sh
sudo useradd -U hadoop
sudo usermod -g hadoop [username]
```

## IP change(Install: Internet with ```enp0s3```)
```sh
sudo vi /etc/network/interfaces
```

```sh
auto enp0s3
iface enp0s3 inet dhcp


auto enp0s8
iface enp0s8 inet static
address 192.168.56.101
netmask 255.255.255.0
```


```sh
sudo vi /etc/resolv.conf

#My ROUTER IP
nameserver 131.121.45.1
#Google DNS Server
nameserver 8.8.8.8
```

and

```sh
sudo /etc/init.d/networking restart
sudo service networking restart
```
In many cases, This will works better. 
```sh
shutdown -r now
```

---
## Install JAVA

```sh
sudo apt-get update
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
java -version

sudo apt-get install default-jdk # alternavitives

vi ~/.bashrc

export JAVA_HOME=/usr/lib/jvm/java-8-oracle
```

## Setup IP alias
```sh
sudo vi /etc/hosts

127.0.0.1         localhost

192.168.56.101     hdc-namenode-0
#192.168.56.102     hdc-namenode-1

192.168.56.111     hdc-datanode-0
192.168.56.112     hdc-datanode-1
192.168.56.113     hdc-datanode-2
#192.168.56.114     hdc-datanode-3
```

## Setup SSH Server

```sh
sudo apt-get install openssh-server
ssh-keygen -t rsa -P ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

## Configuring Key Based Login

```sh
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hdc-namenode-0
#ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hdc-namenode-1
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hdc-datanode-0
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hdc-datanode-1
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hdc-datanode-2
#ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hdc-datanode-3
#chmod 0600 ~/.ssh/authorized_keys

```

## Prepare DataNode (Clone VM to IMPORT)

## Change Hostname

```sh
sudo vi /etc/hostname
sudo vi /etc/network/interfaces
```

## Install Hadoop with Ambari

```
wget -nv http://public-repo-1.hortonworks.com/ambari/ubuntu14/2.x/updates/2.4.1.0/ambari.list -O /etc/apt/sources.list.d/ambari.list

apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD 

apt-get update 

```

```sh
mkdir apps
cd apps
wget http://www.apache.org/dist/ambari/ambari-2.4.2/apache-ambari-2.4.2-src.tar.gz
tar zxvf apache-ambari-2.4.2-src.tar.gz
ln -s apache-ambari-2.4.2-src apache-ambari
cd apache-ambari



```

```sh
cd /usr/local/
sudo wget http://www.us.apache.org/dist/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz
sudo tar -xzvf hadoop-2.7.2.tar.gz >> /dev/null
sudo mv hadoop-2.7.2 /usr/local/hadoop
sudo mkdir -p /usr/local/hadoop_work/hdfs/namenode
sudo mkdir -p /usr/local/hadoop_work/hdfs/namesecondary

sudo chown -R [user]:hadoop hadoop
sudo chown -R [user]:hadoop hadoop_work
```

## Setup Environment

```sh
cd /usr/lib/jvm/java-8-oracle/jre
java -version
```
```sh
/usr/lib/jvm/java-8-oracle/jre# vi ~/.bashrc

# Hadoop
export JAVA_HOME=/usr/lib/jvm/java-7-oracle/jre
export PATH=$PATH:$JAVA_HOME/bin
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin
export PATH=$PATH:$HADOOP_HOME/sbin
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop
export HADOOP_LOG_DIR=/usr/local/hadoop_log/hadoop/logs
export YARN_LOG_DIR=/usr/local/hadoop_log/yarn/logs
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
export CLASSPATH=$CLASSPATH:/usr/local/hadoop/lib/*:.
export HADOOP_CLASSPATH=$HADOOP_HOME/etc/hadoop



export HADOOP_OPTS="$HADOOP_OPTS -Djava.security.egd=file:/dev/../dev/urandom"
source ~/.bashrc
```

## Setup ```JAVA_HOME``` under hadoop environment

```sh
sudo vi /usr/local/hadoop/etc/hadoop/hadoop-env.sh

export JAVA_HOME=/usr/lib/jvm/java-7-oracle/jre

```

## Confirm Hadoop is installed

```sh
cd $HADOOP_HOME/etc/hadoop
hadoop version
```

---
# Configuring the NameNode

## Configure ```core-site.xml```


```sh
cd /usr/local/hadoop/etc/hadoop
vi core-site.xml
```
```xml
<?xml version="1.0"?>
<!-- core-site.xml -->
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://NameNode:8020/</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/usr/local/hadoop_dat/tmp</value>
    </property>
    <property>
        <name>io.file.buffer.size</name>
        <value>131072</value>
    </property>
</configuration>
```
or  
<name>fs.defaultFS</name>  
<value>hdfs://namenode:9000</value>

## Confiture ```hdfs-site.xml```

```sh
vi hdfs-site.xml
```

```xml
<?xml version="1.0"?>
<!-- hdfs-site.xml -->
<configuration>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:///usr/local/hadoop_dat/hdfs/namenode</value>
    </property>
    <property>
        <name>dfs.namenode.checkpoint.dir</name>
        <value>file:///usr/local/hadoop_dat/hdfs/namesecondary</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>file:///usr/local/hadoop_dat/hdfs/datanode</value>
    </property>
    <property>
        <name>dfs.replication</name>
        <value>2</value>
    </property>
    <property>
        <name>dfs.block.size</name>
        <value>134217728</value>
    </property>
</configuration>
```

## Confiture ```mapred-site.xml```

```sh
cp mapred-site.xml.template mapred-site.xml
vi mapred-site.xml
```

```xml
<?xml version="1.0"?>
<!-- mapred-site.xml -->
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>mapred.job.tracker</name>
        <value>namenode:9001</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.address</name>
        <value>NameNode:10020</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.webapp.address</name>
        <value>NameNode:19888</value>
    </property>
    <property>
        <name>yarn.app.mapreduce.am.staging-dir</name>
        <value>hdfs://user/app</value>
    </property>
    <property>
        <name>mapred.child.java.opts</name>
        <value>-Djava.security.egd=file:/dev/../dev/urandom</value>
    </property>
</configuration>
```




## Confiture ```yarn-site.xml```

```sh
vi yarn-site.xml
```

```xml
<?xml version="1.0"?>
<!-- yarn-site.xml -->
<configuration>
    <property>
        <name>yarn.resourcemanager.hostname</name>
        <value>NameNode</value>
    </property>
    <property>
                <name>yarn.resourcemanager.hostname</name>
                <value>hd0m1</value>
        </property>
        <property>
                <name>yarn.resourcemanager.address</name>
                <value>hd0m1:8032</value>
        </property>
        <property>
                <name>yarn.nodemanager.hostname</name>
                <value>hd0m1</value>
        </property>
        <property>
                <name>yarn.nodemanager.address</name>
                <value>hd0m1:0</value>
        </property>
        <property>
                <name>yarn.nodemanager.webapp.address</name>
                <value>hd0m1:8042</value>
        </property>
        <property>
                <name>yarn.resourcemanager.webapp.address</name>
                <value>hd0m1:8088</value>
        </property>
        <property>
                <name>yarn.resourcemanager.webapp.https.address</name>
                <value>hd0m1:8090</value>
        </property>
        <property>
                <name>yarn.resourcemanager.resource-tracker.address</name>
                <value>hd0m1:8031</value>
        </property>
        <property>
                <name>yarn.resourcemanager.admin.address</name>
                <value>hd0m1:8033</value>
        </property>

        <property>
                <name>yarn.nodemanager.log-dirs</name>
                <value>/usr/local/hadoop_log/yarn/nodemanager/logs</value>
        </property>
        <property>
                <name>yarn.nodemanager.aux-services</name>
                <value>mapreduce_shuffle</value>
        </property>
        <property>
                <name>yarn.nodemanager.aux-services.mapreduce_shuffle.class</name>
                <value>org.apache.hadoop.mapred.ShuffleHandler</value>
        </property>
        <property>
                <name>yarn.log-aggregation-enable</name>
                <value>true</value>
        </property>
 <property>
                <name>yarn.nodemanager.local-dirs</name>
                <value>file:///usr/local/hadoop_var/yarn/local</value>
        </property>
        <property>
                <name>yarn.nodemanager.remote-app-log-dir</name>
                <value>hdfs://hd0m1:8020/var/log/hadoop-yarn/apps</value>
        </property>
</configuration>
```

## Configure ```hadoop-env.sh``` for logs
```sh
cd /usr/local/hadoop/etc/hadoop
vi hadoop-env.sh
```
```sh
export HADOOP_LOG_DIR=/usr/local/hadoop_log/hadoop/logs/$USER
```

## Configure ```yarn-env.sh``` or ```~/.bashrc``` for logs
```sh
cd /usr/local/hadoop/etc/hadoop
vi yarn-env.sh
```
```sh
export YARN_LOG_DIR=/usr/local/hadoop_log/yarn/logs
```
or
```sh
export YARN_LOG_DIR=/usr/local/hadoop_log/yarn/logs
```




## Configure ```mapred-env.sh``` for logs
```sh
cd /usr/local/hadoop/etc/hadoop
vi mapred-env.sh
```
```sh
export HADOOP_MAPRED_LOG_DIR=/usr/local/hadoop_log/mapred/logs
export HADOOP_MAPRED_PID_DIR=/usr/local/hadoop_var/mapred/pid
```

## Setup the Master

```sh
vi masters
```

```sh
hd0m1
```

```sh
/usr/local/hadoop/bin/hadoop namenode -format
```

You would see the message:
>Storage directory /usr/local/hadoop_work/hdfs/namenode has been successfully formatted.

Please check hdfs is running properly:
```sh
hdfs dfs -ls
```

In case you meet ```WARN util.NativeCodeLoader``` error, move your native-hadoop-library:
```sh
cd $HADOOP_HOME/lib/native
sudo mv * ../
```



[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)
