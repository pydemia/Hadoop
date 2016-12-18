# Zookeeper
ssh dawkiny@hd0m2 zkServer.sh start
ssh dawkiny@hd0s1 zkServer.sh start
ssh dawkiny@hd0s2 zkServer.sh start
ssh dawkiny@hd0s3 zkServer.sh start
ssh dawkiny@hd0s4 zkServer.sh start

# Kafka
source ~/.bashrc
ssh dawkiny@hd0m2 kafka-server-start.sh server.properties
ssh dawkiny@hd0s1 kafka-server-start.sh server.properties
ssh dawkiny@hd0s2 kafka-server-start.sh server.properties
ssh dawkiny@hd0s3 kafka-server-start.sh server.properties
ssh dawkiny@hd0s4 kafka-server-start.sh server.properties

