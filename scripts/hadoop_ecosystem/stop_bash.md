#--------------Stop all ----------------#


# Zookeeper
zkServer.sh stop
ssh dawkiny@hd0m2 <(zkServer.sh stop)
ssh dawkiny@hd0s1 <(zkServer.sh stop)
ssh dawkiny@hd0s2 <(zkServer.sh stop)
ssh dawkiny@hd0s3 <(zkServer.sh stop)
ssh dawkiny@hd0s4 <(zkServer.sh stop)


# Kafka
kafka-server-stop.sh
ssh dawkiny@hd0m2 <(kafka-server-stop.sh)
ssh dawkiny@hd0s1 <(kafka-server-stop.sh)
ssh dawkiny@hd0s2 <(kafka-server-stop.sh)
ssh dawkiny@hd0s3 <(kafka-server-stop.sh)
ssh dawkiny@hd0s4 <(kafka-server-stop.sh)

