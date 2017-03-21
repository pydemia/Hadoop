# Hadoop on Ubuntu

## Basic Setting
* [Prepare VM](https://github.com/dawkiny/Hadoop/blob/master/scripts/basic_setting/vmsetting.md)   
* [NameNode Setting](https://github.com/dawkiny/Hadoop/blob/master/scripts/basic_setting/namenode_setting.md)  
* [DataNode Setting](https://github.com/dawkiny/Hadoop/blob/master/scripts/basic_setting/datanode_setting.md)  
* [SecondaryNameNode Setting](https://github.com/dawkiny/Hadoop/blob/master/scripts/basic_setting/secondarynamenode_setting.md)  
* [Check HDFS](https://github.com/dawkiny/Hadoop/blob/master/scripts/basic_setting/check_hdfs.md)  

## Hadoop Directory Management
* [Hadoop Directory Management](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/manage_dir.md)  

## Easy Install
* [Install Hadoop with Ambari](https://github.com/pydemia/Hadoop/blob/master/scripts/easyinstall.md#easyinstall)


## Hadoop Ecosystem
* [Ambari](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/ambari.md)  
* [Zookeeper](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/zookeeper.md)  
* [Hbase](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/hbase.md)  
* [Sqoop](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/sqoop.md)  
* [Kafka](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/kafka.md)  
* [Pig](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/pig.md)  
* [Tez](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/tez.md)  
* [Tez UI](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/tez_ui.md)  
* [Hive](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/hive.md)  
  1. [Hive_Usage](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/hive_usage.md)  

---
* [Oozie](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/oozie.md)  
* [Flume](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/flume.md)  
* [Storm](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/storm.md)  
* [Mahout](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/mahout.md)  
* [Spark](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/spark.md)  
  * [Install Jupyter on Spark Master]()


* [Avro](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/avro.md)  
* [Slider](https://github.com/dawkiny/Hadoop/blob/master/scripts/hadoop_ecosystem/slider.md) 


### VirtualBox Import Appliances

After `Import Appliances`:

```sh
rm /etc/udev/rules.d/70-persistent-ipoib.rules 
shutdown -r now
```
