# Set up ```Hive```


## Install ```MariaDB```

```sh
sudo apt-get update
sudo apt install mariadb-server
```
or
```sh
cd /usr/local/hadoop_eco
wget https://downloads.mariadb.org/f/mariadb-10.1.20/bintar-linux-x86_64/mariadb-10.1.20-linux-x86_64.tar.gz
tar -zxf mariadb-10.1.20-linux-x86_64.tar.gz
ln -s mariadb-10.1.20-linux-x86_64 mariadb

```

## Create ```my.cnf``` for ```mariadb```
```sh
cd mariadb
cp support-files/my-innodb-heavy-4G.cnf ~/my.cnf
cp support-files/my-medium.cnf ~/my.cnf
```

```sh
vi my.cnf
```
```sh
[client-server]
# Uncomment these if you want to use a nonstandard connection to MariaDB
socket=/tmp/mysql.sock
port=3306

# This will be passed to all MariaDB clients
[client]
#password=my_password

# The MariaDB server
[mysqld]
# Directory where you want to put your data
data=/usr/local/mysql/var
# Directory for the errmsg.sys file in the language you want to use
language=/usr/local/share/mysql/english
# Create a file where the InnoDB/XtraDB engine stores it's data
loose-innodb_data_file_path = ibdata1:1000M
loose-innodb_file_per_table

# This is the prefix name to be used for all log, error and replication files
log-basename=mysqld

# Enable logging by default to help find problems
general-log
log-slow-queries
```
```sh
cd mariadb
./scripts/mysql_install_db --defaults-file=~/my.cnf 
'./bin/mysqladmin' -u root password root
'./bin/mysqladmin' -u root -h hd0m1 password root
```
Optional:
```sh
'./bin/mysql_secure_installation'
```


## Start ```mariadb```
```sh
cd /usr/local/hadoop_eco/mariadb
./bin/mysqld_safe --defaults-file=~/my.cnf --socket=/tmp/mysql.sock &

```

To Autostart ```mariadb```
```sh
sudo cp support-files/mysql.server /etc/init.d/mysql.server
```



```sh
vi ~/.bashrc
```
```sh
# MariaDB for Hive
export MARIADB_HOME=/usr/local/hadoop_eco/mariadb
export PATH=$PATH:$MARIADB_HOME/bin

```
and


```sh
sudo service mysql start
sudo mysqld start
sudo mysql -uroot -proot
```
```sh
mysqld> create database hive_metastore_db;
grant all privileges on *.* to 'hive'@'localhost' IDENTIFIED BY 'hive' WITH GRANT OPTION;
grant all privileges on *.* to 'hive'@'%' IDENTIFIED BY 'hive' WITH GRANT OPTION;
grant all privileges on *.* to 'hive'@'hd0m1' IDENTIFIED BY 'hive' WITH GRANT OPTION;
grant all privileges on *.* to 'hive'@'192.168.56.%' IDENTIFIED BY 'hive' WITH GRANT OPTION;
SELECT user, host from mysql.user;

```


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
    <value>/tmp/hive/exec_scratch/${system:user.name}</value>
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
    <value>/logs/hive/querylog</value>
    <description>Scratch space for Hive jobs</description>
  </property>
    <property>
    <name>hive.metastore.warehouse.dir</name>
    <value>/user/hive/warehouse</value>
    <description>location of default database for the warehouse</description>
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
      <name>javax.jdo.option.ConnectionURL</name>
    <value>jdbc:mysql://hd0m1:3306/hive_metastore_db?createDatabaseIfNotExist=true</value>
    <description>
      JDBC connect string for a JDBC metastore.
      To use SSL to encrypt/authenticate the connection, provide database-specific SSL flag in the connection URL.
      For example, jdbc:postgresql://myhost/db?ssl=true for postgres database.
    </description>
  </property>
   <property>
    <name>javax.jdo.option.ConnectionDriverName</name>
    <value>org.mariadb.jdbc.Driver</value>
    <description>Driver class name for a JDBC metastore</description>
  </property>
    <property>
    <name>hive.security.authorization.enabled</name>
    <value>true</value>
    <description>enable or disable the Hive client authorization</description>
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

## Put your ```mariadb-connector/j``` in ```$HIVE_HOME/lib```
```sh
cd /usr/local/hadoop_eco/hive/lib
wget https://downloads.mariadb.com/Connectors/java/connector-java-1.5.6/mariadb-java-client-1.5.6.jar```
```

## Start Hadoop
```sh
bash ~/start-all.sh
```

## Reset ```Hive Metastore```(>=```Hive2.x```) + Upgrade
```sh
cd /usr/local/hadoop_eco/hive/bin
./schematool -initSchema -dbType mysql
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
schematool -initSchema -dbType mysql
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

## Start ```Beeline```
```sh
beeline
beeline> !connect jdbc:hive2://hd0m1:10000
---------------------------------------------------
Connecting to jdbc:hive2://hd0m1:10000
Enter username for jdbc:hive2://hd0m1:10000: dawkiny
Enter password for jdbc:hive2://hd0m1:10000: ***
Connected to: Apache Hive (version 2.1.1)
Driver: Hive JDBC (version 2.1.1)
16/12/26 01:54:05 [main]: WARN jdbc.HiveConnection: Request to set autoCommit to false; Hive does not support autoCommit=false.
Transaction isolation: TRANSACTION_REPEATABLE_READ
0: jdbc:hive2://hd0m1:10000> 

```
## Use ```Squirrel SQL```

### Name
Hive JDBC Driver

### Example URL
```sh
jdbc:hive2://192.168.56.11:10000
```

### Extra Class Path
in ```$HADOOP_HOME/share/hadoop/common```  
* ```hadoop-common-*.jar```  
in ```$HADOOP_HOME/share/hadoop/common/lib```
* ```hadoop-auth-*.jar```  
in ```$HIVE_HOME/jdbc```
* ```hive-jdbc-*-standalone.jar```  

### Class Name
```sh
org.apache.hive.jdbc.HiveDriver
```


## Stop ```Hive```

```sh
hive --service hiveserver2 stop
```

## Fix ```SLF4J``` path
```sh
SLF4J: Class path contains multiple SLF4J bindings.
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

