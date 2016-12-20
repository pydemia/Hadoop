[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)


# Set up ```kafka```

## Download & Install

```sh
cd /usr/local/hadoop_eco
wget http://www.us.apache.org/dist/kafka/0.10.1.0/kafka_2.10-0.10.1.0.tgz
tar xvzf kafka_2.10-0.10.1.0.tgz
mv kafka_2.10-0.10.1.0/ kafka
```

## Export ```kafka``` environment path
```sh
export KAFKA_HOME=/usr/local/hadoop_eco/kafka
```

## ```kafka``` Configuration

```sh
vi $KAFKA_HOME/config/server.properties
```

```sh
broker.id=1                  # It must be unique for each node
delete.topic.enable=true     # If you want to delete topic properly
log.dirs=$KAFKA_HOME/kafka-logs
zookeeper.connect=hd0m1:2181,hd0m2:2181,hd0s1:2181,hd0s2:2181,hd0s3:2181,hd0s4:2181

```


## Start ```kafka```
```sh
cd /usr/local/hadoop_eco/kafka
zookeeper-server-start.sh $KAFKA_CONFIG/zookeeper.properties    # embedded zookeeper: zookeeper is needed for running kafka
kafka-server-start.sh $KAFKA_CONFIG/server.properties
```

## Stop ```kafka```
```sh
kafka-server-stop.sh
```

---
## Usage

### Create ```topic```


```sh
kafka-topics.sh --create --zookeeper hd0m1:2181 --replication-factor 1 --partitions 1 --topic test
```

### Check ```topic```
```sh
kafka-topics.sh --list --zookeeper hd0m1:2181
```

### Run ```producer```

```sh
kafka-console-producer.sh --broker-list hd0m1:9092 --topic test
```

#### Input message

```sh
This is Message
This is second message
```

#### Create ```consumer```

```sh
kafka-console-consumer.sh --zookeeper hd0m1:2181 --topic test --from-beginning
```

#### Input Another message

```sh
This is third message
```

#### Delete ```topic```

**_[Important]_**
```sh
kafka-topics.sh --delete --zookeeper hd0m1:2181 --topic test --from-beginning
```


##### Edit ```server.properties```

```sh
vi $KAFKA_HOME/config/server.properties


delete.topic.enable = true
```


[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)
