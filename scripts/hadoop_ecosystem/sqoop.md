[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)


# Set up ```Sqoop```


## Download ```Sqoop```
```sh
cd /usr/local/hadoop_eco
wget http://archive.apache.org/dist/sqoop/1.99.7/sqoop-1.99.7-bin-hadoop200.tar.gz
tar -xzf sqoop-1.99.7-bin-hadoop200.tar.gz
mv sqoop-1.99.7-bin-hadoop200 sqoop
```

## Setting to use ```Sqoop```

```sh
vi ~/.bashrc
```
```sh
# Sqoop
export SQOOP_HOME=/usr/local/hadoop_eco/sqoop
export PATH=$PATH:$SQOOP_HOME/bin
export SQOOP_CONF_DIR=$SQOOP_HOME/conf
export SQOOP_CLASS_PATH=$SQOOP_CONF_DIR
export SQOOP_SERVER_EXTRA_LIB=/usr/local/hadoop_eco/sqoop/libs
```
```sh
source ~/.bashrc
```

## Configuration option: Create Symbolic links from ```Hadoop``` to ```Sqoop```

This is the way you manually put the ```*.jar``` files from ```Hadoop``` to ```Sqoop```.
```sh
ln -s /usr/local/hadoop/share/hadoop/common/*.jar /usr/local/hadoop_eco/sqoop/server/lib
ln -s /usr/local/hadoop/share/hadoop/common/lib/*.jar /usr/local/hadoop_eco/sqoop/server/lib

ln -s /usr/local/hadoop/share/hadoop/hdfs/*.jar /usr/local/hadoop_eco/sqoop/server/lib
ln -s /usr/local/hadoop/share/hadoop/hdfs/lib/*.jar /usr/local/hadoop_eco/sqoop/server/lib

ln -s /usr/local/hadoop/share/hadoop/mapreduce/*.jar /usr/local/hadoop_eco/sqoop/server/lib
ln -s /usr/local/hadoop/share/hadoop/mapreduce/lib/*.jar /usr/local/hadoop_eco/sqoop/server/lib

ln -s /usr/local/hadoop/share/hadoop/yarn/*.jar /usr/local/hadoop_eco/sqoop/server/lib
ln -s /usr/local/hadoop/share/hadoop/yarn/lib/*.jar /usr/local/hadoop_eco/sqoop/server/lib
```
In case ```failed to create symbolic link: File exists```, just ignore it and keep forward.


## Configure ```HDFS``` ```core-site.xml```

```sh
cd /usr/local/hadoop/etc/hadoop
vi core-site.xml
```
```xml
<configuration>
        <property>
                <name>fs.defaultFS</name>
                <value>hdfs://hd0m1:8020/</value>
        </property>
        <property>
                <name>io.file.buffer.size</name>
                <value>131072</value>
        </property>
        <property>
                <name>dfs.replication</name>
                <value>3</value>
        </property>

        <!-- Sqoop and Oozie proxy user setting -->
        <property>
                <name>hadoop.proxyuser.dawkiny.hosts</name>
                <value>*</value>
        </property>
        <property>
                <name>hadoop.proxyuser.dawkiny.groups</name>
                <value>*</value>
        </property>
</configuration>

```

[Apache Hadoop ```core-site.xml``` example](https://hadoop.apache.org/docs/r2.7.2/hadoop-project-dist/hadoop-common/core-default.xml)

If you’re running Sqoop 2 server under a so-called  
system user (user with ```UID``` less then ```min.user.id``` - ```1000``` by default),  
then *__```YARN``` will by default refuse to run ```Sqoop2``` jobs_**.   
You will need to add the ```username``` who is running ```Sqoop2``` server   
(most likely user ```sqoop2```, In my case ```dawkiny```)    
to a ```allowed.system.users``` property of ```container-executor.cfg```.   
Please refer to ```YARN``` documentation for further details.  

Example fragment that needs to be present in ```container-executor.cfg``` file 
for case when server is running under ```dawkiny``` user:
```sh
cd /usr/local/hadoop/etc/hadoop
vi container-executor.cfg
```
```sh
#configured value of yarn.nodemanager.linux-container-executor.group
yarn.nodemanager.linux-container-executor.group=

# comma separated list of users who can not run applications
banned.users=

# Prevent other super-users
min.user.id=1000

# comma separated list of system users who CAN run applications
allowed.system.users=dawkiny
```
 
## For 3rd-party ```jar```
```sh
mkdir -p /usr/local/hadoop_eco/sqoop/libs/

cp mysql-jdbc*.jar /usr/local/hadoop_eco/sqoop/libs/
cp postgresql-jdbc*.jar /usr/local/hadoop_eco/sqoop/libs/
```
or

```sh
cp ~/connectors/*.jar /usr/local/hadoop_eco/sqoop/libs/
```


## ```Sqoop``` Configuration

```sh
cd /usr/local/hadoop_eco/sqoop/conf
vi sqoop_bootstrap.properties 
```
and 

```
cd /usr/local/hadoop_eco/sqoop/conf
vi sqoop.properties 
```
```sh
org.apache.sqoop.log4j.appender.file.File=/usr/local/hadoop_log/sqoop/sqoop.log
# Default: conf/@LOGDIR@/sqoop.log

org.apache.sqoop.log4j.appender.audit.File=/usr/local/hadoop_log/sqoop/audit.log
# Default: conf/@LOGDIR@/audit.log

org.apache.sqoop.repository.sysprop.derby.stream.error.file=/usr/local/hadoop_log/sqoop/derbyrepo.log
# Default: conf/@LOGDIR@/derbyrepo.log

org.apache.sqoop.submission.engine.mapreduce.configuration.directory=/usr/local/hadoop/etc/hadoop/
# Default: /etc/hadoop/lib/
```
Default or very little tweaking should be **_sufficient_** in most common cases.

## Repository Initialization
```sh
sqoop2-tool upgrade
------------------------
Setting conf dir: /usr/local/hadoop_eco/sqoop/conf
Sqoop home directory: /usr/local/hadoop_eco/sqoop
Sqoop tool executor:
	Version: 1.99.7
	Revision: 435d5e61b922a32d7bce567fe5fb1a9c0d9b1bbb
	Compiled on Tue Jul 19 16:08:27 PDT 2016 by abefine
Running tool: class org.apache.sqoop.tools.tool.UpgradeTool
2016-12-21 00:18:03,820 INFO  [main] core.PropertiesConfigurationProvider (PropertiesConfigurationProvider.java:initialize(99)) - Starting config file poller thread
Tool class org.apache.sqoop.tools.tool.UpgradeTool has finished correctly.
------------------------
```

```sh
sqoop2-tool verify
```

## Start ```Sqoop```
```sh
sqoop2-server start
------------------------
Setting conf dir: /usr/local/hadoop_eco/sqoop/conf
Sqoop home directory: /usr/local/hadoop_eco/sqoop
Starting the Sqoop2 server...
2016-12-21 01:00:24,060 INFO  [main] core.SqoopServer (SqoopServer.java:initialize(55)) - Initializing Sqoop server.
2016-12-21 01:00:24,078 INFO  [main] core.PropertiesConfigurationProvider (PropertiesConfigurationProvider.java:initialize(99)) - Starting config file poller thread
Sqoop2 server started.
------------------------
```

```sh
jps
------------------------
1744 NameNode
13676 Jps
2129 JobHistoryServer
3134 QuorumPeerMain
13648 SqoopJettyServer
------------------------
```

## Stop ```Sqoop```
```sh
sqoop2-server stop
------------------------
Setting conf dir: /usr/local/hadoop_eco/sqoop/conf
Sqoop home directory: /usr/local/hadoop_eco/sqoop
Stopping the Sqoop2 server...
Sqoop2 server stopped.
------------------------
```

## Show logs

```sh
cd /usr/local/hadoop_eco/sqoop/conf/@LOGDIR@
```

## Use Client with ```sqoop2-shell```

```sh
sqoop2-shell
------------------------
Setting conf dir: /usr/local/hadoop_eco/sqoop/conf
Sqoop home directory: /usr/local/hadoop_eco/sqoop
Dec 21, 2016 1:02:11 AM java.util.prefs.FileSystemPreferences$1 run
INFO: Created user preferences directory.
Sqoop Shell: Type 'help' or '\h' for help.

sqoop:000> help
For information about Sqoop, visit: http://sqoop.apache.org/

Available commands:
  :exit    (:x  ) Exit the shell
  :history (:H  ) Display, manage and recall edit-line history
  help     (\h  ) Display this help message
  set      (\st ) Configure various client options and settings
  show     (\sh ) Display various objects and configuration options
  create   (\cr ) Create new object in Sqoop repository
  delete   (\d  ) Delete existing object in Sqoop repository
  update   (\up ) Update objects in Sqoop repository
  clone    (\cl ) Create new object based on existing one
  start    (\sta) Start job
  stop     (\stp) Stop job
  status   (\stu) Display status of a job
  enable   (\en ) Enable object in Sqoop repository
  disable  (\di ) Disable object in Sqoop repository
  grant    (\g  ) Grant access to roles and assign privileges
  revoke   (\r  ) Revoke access from roles and remove privileges

For help on a specific command type: help command

sqoop:000> 
------------------------
```


  
  
---
# Use ```Sqoop```

## RDBMS to Hadoop

```sh

```

[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)
