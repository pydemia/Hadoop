


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


## Download ```Tez```
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
</configuration>
```

## Configure ```hdfs-site.xml```
```
cd 
```
