# ETL from ```mariadb``` to ```hive```

## MariaDB check
```sh
MariaDB [(none)]> USE employees; DESCRIBE employees;

+------------+---------------+------+-----+---------+-------+
| Field      | Type          | Null | Key | Default | Extra |
+------------+---------------+------+-----+---------+-------+
| emp_no     | int(11)       | NO   | PRI | NULL    |       |
| birth_date | date          | NO   |     | NULL    |       |
| first_name | varchar(14)   | NO   |     | NULL    |       |
| last_name  | varchar(16)   | NO   |     | NULL    |       |
| gender     | enum('M','F') | NO   |     | NULL    |       |
| hire_date  | date          | NO   |     | NULL    |       |
+------------+---------------+------+-----+---------+-------+

```

## With ```sqoop```

```sh
cd /usr/local/hadoop_eco/sqoop/server/lib
wget https://downloads.mariadb.com/Connectors/java/connector-java-1.5.6/mariadb-java-client-1.5.6.jar

```


```sh
sqoop2-shell
----------------------------
sqoop:000> show connector

0    [main] WARN  org.apache.hadoop.util.NativeCodeLoader  - Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
+------------------------+---------+------------------------------------------------------------+----------------------+
|          Name          | Version |                           Class                            | Supported Directions |
+------------------------+---------+------------------------------------------------------------+----------------------+
| oracle-jdbc-connector  | 1.99.7  | org.apache.sqoop.connector.jdbc.oracle.OracleJdbcConnector | FROM/TO              |
| sftp-connector         | 1.99.7  | org.apache.sqoop.connector.sftp.SftpConnector              | TO                   |
| kafka-connector        | 1.99.7  | org.apache.sqoop.connector.kafka.KafkaConnector            | TO                   |
| kite-connector         | 1.99.7  | org.apache.sqoop.connector.kite.KiteConnector              | FROM/TO              |
| ftp-connector          | 1.99.7  | org.apache.sqoop.connector.ftp.FtpConnector                | TO                   |
| hdfs-connector         | 1.99.7  | org.apache.sqoop.connector.hdfs.HdfsConnector              | FROM/TO              |
| generic-jdbc-connector | 1.99.7  | org.apache.sqoop.connector.jdbc.GenericJdbcConnector       | FROM/TO              |
+------------------------+---------+------------------------------------------------------------+----------------------+

sqoop:000> create link -c 1

sqoop import --connect jdbc:mysql://192.168.56.101:3306/employees --username mdb --password mdb
```



```sh
hive> CREATE DATABASE IF NOT EXISTS hdb;
hive>
CREATE TABLE hdb.employees 
(
emp_no  INT,
birth_data  DATE,
first_name  VARCHAR(14),
last_name  VARCHAR(16),
gender  VARCHAR(1),
hire_date DATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;
```
