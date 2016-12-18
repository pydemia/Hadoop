# Push .bashrc
scp -r ~/.bashrc dawkiny@hd0m2:~/
scp -r ~/.bashrc dawkiny@hd0s1:~/
scp -r ~/.bashrc dawkiny@hd0s2:~/
scp -r ~/.bashrc dawkiny@hd0s3:~/
scp -r ~/.bashrc dawkiny@hd0s4:~/

# Push Haddop Ecosystem Folder
scp -r /usr/local/hadoop_eco dawkiny@hd0m2:/usr/local/
scp -r /usr/local/hadoop_eco dawkiny@hd0s1:/usr/local/
scp -r /usr/local/hadoop_eco dawkiny@hd0s2:/usr/local/
scp -r /usr/local/hadoop_eco dawkiny@hd0s3:/usr/local/
scp -r /usr/local/hadoop_eco dawkiny@hd0s4:/usr/local/

# Push Unique Variable for Each Node

## Zookeeper
scp -r /usr/local/hadoop_eco/node_variables/hd0m2/myid dawkiny@hd0m2:/usr/local/hadoop_eco/zookeeper/data/
scp -r /usr/local/hadoop_eco/node_variables/hd0s1/myid dawkiny@hd0s1:/usr/local/hadoop_eco/zookeeper/data/
scp -r /usr/local/hadoop_eco/node_variables/hd0s2/myid dawkiny@hd0s2:/usr/local/hadoop_eco/zookeeper/data/
scp -r /usr/local/hadoop_eco/node_variables/hd0s3/myid dawkiny@hd0s3:/usr/local/hadoop_eco/zookeeper/data/
scp -r /usr/local/hadoop_eco/node_variables/hd0s4/myid dawkiny@hd0s4:/usr/local/hadoop_eco/zookeeper/data/

## Kafka
scp -r /usr/local/hadoop_eco/node_variables/hd0m2/server.properties dawkiny@hd0m2:/usr/local/hadoop_eco/kafka/config/
scp -r /usr/local/hadoop_eco/node_variables/hd0s1/server.properties dawkiny@hd0s1:/usr/local/hadoop_eco/kafka/config/
scp -r /usr/local/hadoop_eco/node_variables/hd0s2/server.properties dawkiny@hd0s2:/usr/local/hadoop_eco/kafka/config/
scp -r /usr/local/hadoop_eco/node_variables/hd0s3/server.properties dawkiny@hd0s3:/usr/local/hadoop_eco/kafka/config/
scp -r /usr/local/hadoop_eco/node_variables/hd0s4/server.properties dawkiny@hd0s4:/usr/local/hadoop_eco/kafka/config/
