# Set up ```Hive``` (on ```secondNameNode```)

## Download & Install ```Hive```

```sh
cd /usr/local/hadoop_eco
wget http://apache.mirror.cdnetworks.com/hive/hive-2.1.1/apache-hive-2.1.1-bin.tar.gz
tar -zxf apache-hive-2.1.1-bin.tar.gz 
ln -s apache-hive-2.1.1-bin hive
```

## Configure ```~/.bashrc```

```sh
vi ~/.bashrc
```
```sh
# Hive
export HIVE_HOME=/usr/local/hadoop_eco/hive
export HIVE_CONF_DIR=/usr/local/hadoop_eco/hive/conf
export PATH=$PATH:$HIVE_HOME/bin:$HIVE_CONF_DIR

```


## Configure ```hive-env.sh```

```sh
cd /usr/local/hadoop_eco/hive/conf
cp hive-env.sh.template hive-env.sh
vi hive-env.sh
```
```sh
HADOOP_HOME=/usr/local/hadoop
export HIVE_CONF_DIR=/usr/local/hadoop_eco/hive/conf
```


## Configure ```hive-site.xml```

```sh
cd /usr/local/hadoop_eco/hive/conf
cp hive-default.xml.template hive-site.xml
vi hive-site.xml
```
```xml
<configuration>
  <property>
    <name>hive.exec.scratchdir</name>
    <value>/usr/local/hadoop_dat/hive/exec_scratch</value>
    <description>Scratch space for Hive jobs</description>
  </property>
  <property>
    <name>hive.exec.local.scratchdir</name>
    <value>file:///usr/local/hadoop_dat/hive/exec_local_scratch</value>
    <description>Local Scratch space for Hive jobs</description>
  </property>
    <property>
    <name>hive.downloaded.resources.dir</name>
    <value>/tmp/hive/resources</value>
    <description>Temporary local directory for added resources in the remote file system.</description>
  </property>
    <property>
    <name>hive.scratch.dir.permission</name>
    <value>733</value>
    <description>The permission for the user specific scratch directories that get created.</description>
  </property>
  <property>
    <name>hive.querylog.location</name>
    <value>/logs/hive/querylog/${system:user.name}</value>
    <description>Scratch space for Hive jobs</description>
  </property>
    <property>
    <name>hive.metastore.warehouse.dir</name>
    <value>/user/hive/warehouse/${system:user.name}</value>
    <description>location of default database for the warehouse</description>
  </property>
    <property>
    <name>javax.jdo.option.ConnectionUserName</name>
    <value>APP</value>
    <description>Username to use against metastore database</description>
  </property>
  <property>
    <name>javax.jdo.option.ConnectionPassword</name>
    <value>mine</value>
    <description>password to use against metastore database</description>
  </property>
  <property>
    <name>hive.metastore.ds.connection.url.hook</name>
    <value/>
    <description>Name of the hook to use for retrieving the JDO connection URL. If empty, the value in javax.jdo.option.ConnectionURL is used</description>
  </property>
      <name>javax.jdo.option.ConnectionURL</name>
    <value>jdbc:derby:;databaseName=/usr/local/hadoop_dat/hive/metastore_db;create=true</value>
    <description>
      JDBC connect string for a JDBC metastore.
      To use SSL to encrypt/authenticate the connection, provide database-specific SSL flag in the connection URL.
      For example, jdbc:postgresql://myhost/db?ssl=true for postgres database.
    </description>
  </property>

</configuration>
  
```

## Configure ```hive-log4j.properties```

```sh
cd /usr/local/hadoop_eco/hive/conf
cp hive-log4j2.properties.template hive-log4j2.properties
vi hive-log4j.properties
```
```sh
property.hive.log.dir = /usr/local/hadoop_log/hive/logs/${sys:user.name}


```

## Start Hadoop

## Reset ```Hive Metastore```(>=```Hive2.x```) + Upgrade
```sh
cd /usr/local/hadoop_eco/hive/bin
./schematool -initSchema -dbType [dbtype]
./schematool -initSchema -dbType derby
-----------------------------------------
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/hadoop_eco/apache-hive-2.1.1-bin/lib/log4j-slf4j-impl-2.4.1.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop_eco/apache-tez-0.8.4-src/tez-dist/target/tez-0.8.4/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]
Metastore connection URL:	 jdbc:derby:;databaseName=/usr/local/hadoop_dat/hive/metastore_db;create=true
Metastore Connection Driver :	 org.apache.derby.jdbc.EmbeddedDriver
Metastore connection User:	 APP
Starting metastore schema initialization to 2.1.0
Initialization script hive-schema-2.1.0.derby.sql
Initialization script completed
schemaTool completed

```
If you failed:
```sh
rm -Rf /usr/local/hadoop_dat/hive/metastore_db
schematool -initSchema -dbType derby
```

## Execute ```Hive Shell```
```sh
cd /usr/local/hadoop_eco/hive/bin
./hive
----------------------------
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/hadoop_eco/apache-hive-2.1.1-bin/lib/log4j-slf4j-impl-2.4.1.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop_eco/apache-tez-0.8.4-src/tez-dist/target/tez-0.8.4/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]

Logging initialized using configuration in file:/usr/local/hadoop_eco/apache-hive-2.1.1-bin/conf/hive-log4j2.properties Async: true
Hive-on-MR is deprecated in Hive 2 and may not be available in the future versions. Consider using a different execution engine (i.e. tez, spark) or using Hive 1.X releases.
hive> 

```
## Execute ```beeline```
```sh
beeline -u jdbc:hive2://hd0m1:10000
```

## Set up ```Hiveserver2```

```
vi /usr/local/hadoop_eco/hive/conf/hive-site.xml
```
```xml
  <property>
    <name>hive.server2.thrift.bind.host</name>
    <value>hd0m1</value>
    <description>Bind host on which to run the HiveServer2 Thrift service.</description>
  </property>
  <property>
    <name>hive.server2.webui.host</name>
    <value>hd0m1</value>
    <description>The host address the HiveServer2 WebUI will listen on</description>
  </property>
  <property>
    <name>hive.server2.webui.port</name>
    <value>10002</value>
    <description>The port the HiveServer2 WebUI will listen on. This can beset to 0 or a negative integer to disable the web UI</description>
  </property>

```
Optional: Some can be overridden by setting ```~/.bashrc```:
```sh
#HIVE_SERVER2_THRIFT_PORT=10000
#HIVE_SERVER2_THRIFT_BIND_HOST=hd0m1
```


## Execute ```Hiveserver2```
```sh
hive --service hiveserver2 &
```
or
```sh
hiveserver2
```
```sh
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/hadoop_eco/apache-hive-2.1.1-bin/lib/log4j-slf4j-impl-2.4.1.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop_eco/apache-tez-0.8.4-src/tez-dist/target/tez-0.8.4/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]

```





# Set up ```HCatalog``` & ```WebHCat```

## Configure ```~/.bashrc```
```sh
# HCatalog & WebHCat
export HCATALOG_HOME=/usr/local/hadoop_eco/hive/hcatalog
export WEBCAT_HOME=/usr/local/hadoop_eco/hive/hcatalog
export HCATALOG_CONF_DIR=$HIVE_HOME/hcatalog/conf
export PATH=$PATH:$HCATALOG_HOME/bin:$WEBCAT_HOME/sbin
```
