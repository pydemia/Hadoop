


# Set up ```Tez```

## Check ```Hadoop``` version
Check & change ```Hadoop``` version in the top-level ```pom.xml``` to match the version of the ```Hadoop``` branch being used.
```sh
hadoop version
```

## Install Requirements
You might have already installed ```JDK6``` or later.

Install ```Maven3``` or later.

```sh
sudo apt-get install maven
```
Just in case, install below:

Install ```nodejs```
```sh
sudo apt-get install nodejs
```

Install ```npm```
```sh
sudo apt-get install npm
```

Install ```build-essential```
```sh
sudo apt-get install build-essential
```

Install ```protobuf 2.5```(**_2.5 version is MANDATORY_**)

```sh
cd /usr/local/hadoop_eco
wget https://github.com/google/protobuf/releases/download/v2.5.0/protobuf-2.5.0.tar.gz
tar -zxf protobuf-2.5.0.tar.gz 
mv protobuf-2.5.0 protobuf
cd protobuf-2.5.0/
sudo ./configure
sudo make
sudo make check
sudo make install
sudo ldconfig
protoc --version 
-------------------
libprotoc 2.5.0

```


## Download & Install ```Tez```
```sh
cd /usr/local/hadoop_eco
git clone https://github.com/apache/tez
cd tez
mvn clean package -DskipTests=true -Dmaven.javadoc.skip=true
```


## Configuration

```sh
vi ~/.bashrc
```
```sh
export TEZ_JARS=~/tez/tez-dist/target/tez-0.7.0-SNAPSHOT
export TEZ_CONF_DIR=$TEZ_JARS/conf
export HADOOP_CLASSPATH=$TEZ_CONF_DIR:$TEZ_JARS/*:$TEZ_JARS/lib/*:$HADOOP_CLASSPATH
```


## Configure ```tez-site.xml```
```sh
cd tez-dist/target/tez-0.7.0-SNAPSHOT
mkdir conf
vi conf/tez-site.xml
```
```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
       <name>tez.lib.uris</name>
       <value>${fs.defaultFS}/apps/tez/tez-0.7.0-SNAPSHOT.tar.gz</value>
    </property>
    <property>
        <name>tez.use.cluster.hadoop-libs</name>
        <value>true</value>
    </property>
</configuration>
```
[[```tez-site.xml``` example]](https://github.com/dawkiny/Hadoop/edit/master/scripts/hadoop_ecosystem/tez-site.xml)

## Configure ```hdfs-site.xml```
```
cd 
```
```xml
<?xml version="1.0"?>
<!-- mapred-site.xml -->
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
        <description>
        If running existing MapReduce jobs on Tez, "yarn-tez". or just "yarn"
        </description>
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
        <value>/user/app</value>
    </property>
    <property>
        <name>mapred.child.java.opts</name>
        <value>-Djava.security.egd=file:/dev/../dev/urandom</value>
    </property>
</configuration>
```
