## Set up ```Spark```

## Download ```spark```

```sh
cd /usr/local/hadoop_eco
wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.2.tgz
tar -zxf spark-2.0.2.tgz
ln -s spark-2.0.2 spark
cd spark
./build/mvn -Pyarn -Phadoop-2.7 -Dhadoop.version=2.7.2 -Phive -Phive-thriftserver -DskipTests clean package

```

### Configure ```~/.bashrc```
```sh
vi ~/.bashrc
```

```sh
# Spark
export SPARK_HOME=/usr/local/hadoop_eco/spark
export PATH=$SPARK_HOME/bin
```

