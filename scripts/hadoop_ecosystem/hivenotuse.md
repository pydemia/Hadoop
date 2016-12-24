# Set up ```Hive```

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
export PATH=$PATH:$HIVE_HOME/bin
export HIVE_CONF_DIR=/usr/local/hadoop_eco/hive/conf
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
    <value>/tmp/hive/exec_scratch/${system:user.name}</value>
    <description>Scratch space for Hive jobs</description>
  </property>
  <property>
    <name>hive.exec.local.scratchdir</name>
    <value>/tmp/hive/exec_local_scratch/${system:user.name}</value>
    <description>Scratch space for Hive jobs</description>
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
    <name>javax.jdo.option.ConnectionURL</name>
    <value>jdbc:mysql://hd0m2:3306/hive_metastore_db?createDatabaseIfNotExsist=true</value>
    <description>
      JDBC connect string for a JDBC metastore.
      To use SSL to encrypt/authenticate the connection, provide database-specific SSL flag in the connection URL.
      For example, jdbc:postgresql://myhost/db?ssl=true for postgres database.
    </description>
  </property>
    <property>
    <name>javax.jdo.option.ConnectionDriverName</name>
    <value>com.mysql.jdbc.Driver</value>
    <description>Driver class name for a JDBC metastore</description>
  </property>
  <property>
    <name>javax.jdo.option.ConnectionUserName</name>
    <value>hive</value>
    <description>Username to use against metastore database</description>
  </property>
  <property>
    <name>javax.jdo.option.ConnectionPassword</name>
    <value>hive</value>
    <description>password to use against metastore database</description>
  </property>
  <property>
    <name>hive.metastore.ds.connection.url.hook</name>
    <value/>
    <description>Name of the hook to use for retrieving the JDO connection URL. If empty, the value in javax.jdo.option.ConnectionURL is used</description>
  </property>
    <property>
    <name>javax.jdo.option.ConnectionURL</name>
    <value>jdbc:mysql:;databaseName=metastore_db;create=true</value>
    <description>
      JDBC connect string for a JDBC metastore.
      To use SSL to encrypt/authenticate the connection, provide database-specific SSL flag in the connection URL.
      For example, jdbc:postgresql://myhost/db?ssl=true for postgres database.
    </description>
  </property>

  
```

## Configure ```hive-log4j.properties```

```sh
cd /usr/local/hadoop_eco/hive/conf
cp hive-log4j2.properties.template hive-log4j2.properties
vi hive-log4j.properties
```
```sh
property.hive.log.dir = /usr/local/hadoop_log/hive/logs

```


## Reset ```Hive Metastore```(>=```Hive2.x```) + Upgrade
```sh
cd /usr/local/hadoop_eco/hive/bin
./schematool -initSchema -dbType [dbtype]
./schematool -initSchema -dbType mysql
-----------------------------------------
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/usr/local/hadoop_eco/apache-hive-2.1.1-bin/lib/log4j-slf4j-impl-2.4.1.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop_eco/apache-tez-0.8.4-src/tez-dist/target/tez-0.8.4/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/usr/local/hadoop/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]
Metastore connection URL:	 jdbc:derby:;databaseName=metastore_db;create=true
Metastore Connection Driver :	 org.apache.derby.jdbc.EmbeddedDriver
Metastore connection User:	 APP
Starting metastore schema initialization to 2.1.0
Initialization script hive-schema-2.1.0.derby.sql
Initialization script completed
schemaTool completed

```

## Execute ```Hive Shell```
```sh
cd /usr/local/hadoop_eco/hive/bin
./hive
----------------------------

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
