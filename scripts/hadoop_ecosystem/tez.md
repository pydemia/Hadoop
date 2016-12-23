[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)



# Set up ```Tez```

## Install Requirements
You might have already installed ```JDK6``` or later.

Install ```Maven3``` or later.

```sh
wget https://archive.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz
```

Install ```protobuf 2.5```  (**_2.5 version is MANDATORY_**)

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
wget http://apache.mirror.cdnetworks.com/tez/0.8.4/apache-tez-0.8.4-src.tar.gz
tar -zxf apache-tez-0.8.4-src.tar.gz 
ln -s apache-tez-0.8.4-src tez
```

### Configure ```pom.xml```
Check & change ```Hadoop``` version in the top-level ```pom.xml``` to match the version of the ```Hadoop``` branch being used.
```sh
hadoop version
--------------------
Hadoop 2.7.2
Subversion https://git-wip-us.apache.org/repos/asf/hadoop.git -r b165c4fe8a74265c792ce23f546c64604acf0e41
Compiled by jenkins on 2016-01-26T00:08Z
Compiled with protoc 2.5.0
From source with checksum d0fda26633fa762bff87ec759ebe689c
This command was run using /usr/local/hadoop/share/hadoop/common/hadoop-common-2.7.2.jar
```

```sh
cd tez
vi pom.xml
```
```xml
    <hadoop.version>2.7.2</hadoop.version>
    <jetty.version>6.1.26</jetty.version>
    <pig.version>0.16.0</pig.version>

```


### Install ```Tez```
```sh
mvn clean package -DskipTests=true -Dmaven.javadoc.skip=true
```


## Configure ```~/.bashrc```

```sh
vi ~/.bashrc
```
```sh
# Tez
export TEZ_HOME=/usr/local/hadoop_eco/tez
export TEZ_JARS=$TEZ_HOME/tez-dist/target/tez-0.8.4
export TEZ_CONF_DIR=$TEZ_JARS/conf
export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$TEZ_CONF_DIR:$TEZ_JARS/*:$TEZ_JARS/lib/*
```

## Configure ```mapred-site.xml```
```
cd /usr/local/hadoop/etc/hadoop
vi mapred-site.xml
```
```xml
<?xml version="1.0"?>
<!-- mapred-site.xml -->
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>tez</value>
        <description>
        If running existing MapReduce jobs on Tez, "yarn-tez". or just "yarn"
        </description>
    </property>
</configuration>
```

## ```tez tarball``` into ```HDFS```

```sh
cd /usr/local/hadoop_eco/tez
hdfs dfs -mkdir -p /apps/tez/lib
hdfs dfs -copyFromLocal tez-dist/target/tez-0.8.4.tar.gz /apps/tez/
```


## Configure ```tez-site.xml```
```sh
cd tez-dist/target/tez-0.8.4
mkdir conf
vi conf/tez-site.xml
```
```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
       <name>tez.lib.uris</name>
       <value>${fs.defaultFS}/apps/tez,${fs.defaultFS}/apps/tez/lib</value>
    </property>
    <property>
        <name>tez.use.cluster.hadoop-libs</name>
        <value>false</value>
    </property>
    <property>
  <name>tez.history.logging.service.class</name>
  <value>org.apache.tez.dag.history.logging.ats.ATSHistoryLoggingService</value>
  <description>Enable Tez to use the Timeline Server for History Logging</description>
</property>
<property>
  <name>tez.tez-ui.history-url.base</name>
  <value>http://hd0m1:9999/tez-ui/</value>
  <description>URL for where the Tez UI is hosted</description>
</property>
</configuration>
```
[[```tez-site.xml``` example]](https://github.com/dawkiny/Hadoop/edit/master/scripts/hadoop_ecosystem/tez-site.xml)


## Extract the tez minimal tarball created in step 2
```sh
cd /usr/local/hadoop_eco/tez/tez-dist/target
tar -zxf tez-0.8.4-minimal.tar.gz -C $TEZ_JARS
cd tez-0.8.4-minimal
```

## Configure ```hadoop-env.sh```
```sh
cd /usr/local/hadoop/etc/hadoop
vi hadoop-env.sh
```
```sh
###################
# Tez Setting
###################
export HADOOP_CLIENT_OPTS="-Djava.net.preferIPv4Stack=true $HADOOP_CLIENT_OPTS"
export TEZ_HOME=/usr/local/hadoop_eco/tez
export TEZ_JARS=$TEZ_HOME/tez-dist/target/tez-0.8.4
export TEZ_CONF_DIR=$TEZ_JARS/conf
export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$TEZ_CONF_DIR:$TEZ_JARS/*:$TEZ_JARS/lib/*

```



## Optional: Configure ```hive-env.sh```
```sh
vi hive-env.sh
```
```sh
###################
# Tez Setting
###################
export TEZ_HOME=/usr/local/hadoop_eco/tez
export TEZ_INSTALL_DIR=$TEZ_HOME/tez-dist/target/tez-0.8.4
export TEZ_JARS=$(echo "$TEZ_INSTALL_DIR"/*.jar | tr ' ' ':'):$(echo "$TEZ_INSTALL_DIR"/lib/*.jar | tr ' ' ':')
export TEZ_CONF_DIR=$TEZ_JARS/conf
export HIVE_AUX_JARS_PATH=$TEZ_JARS

```

## Deploy settings to DataNode

Use ```hdfs``` or ```linux```


## Run ```tez-examples-0.8.4.jar``` to run MR Job
```sh
cd /usr/local/hadoop_eco/tez/tez-dist/target/tez-0.8.4-minimal
hadoop jar /usr/local/hadoop_eco/tez/tez-dist/target/tez-0.8.4/tez-examples-0.8.4.jar -DUSE_TEZ_SESSION=true ~/test.txt ~/test
--------------------------------
Unknown program '-DUSE_TEZ_SESSION=true' chosen.
Valid program names are:
  hashjoin: Identify all occurences of lines in file1 which also occur in file2 using hash join
  joindatagen: Generate data to run the joinexample
  joinvalidate: Validate data generated by joinexample and joindatagen
  orderedwordcount: Word Count with words sorted on frequency
  simplesessionexample: Example to run multiple dags in a session
  sortmergejoin: Identify all occurences of lines in file1 which also occur in file2 using sort merge join
  wordcount: A native Tez wordcount program that counts the words in the input files.

```


[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)
