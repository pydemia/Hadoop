[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)



# Set up ```Pig```

## Download ```Pig```

```sh
cd /usr/local/hadoop_eco
wget http://apache.mirror.cdnetworks.com/pig/pig-0.16.0/pig-0.16.0.tar.gz
tar -zxf pig-0.16.0.tar.gz
ln -s pig-0.16.0 pig
```


## Configure ```~/.bashrc```

```sh
vi ~/.bashrc
```
```sh
# Pig
export PIG_HOME=/usr/local/hadoop_eco/pig
export PATH=$PATH:$PIG_HOME/bin
export PIG_CLASSPATH=$HADOOP_CLASSPATH

```
```sh
source ~/.bashrc
```

## Check Version

```sh
pig -version
-------------------------------------
Apache Pig version 0.16.0 (r1746530) 
compiled Jun 01 2016, 23:10:49

```

## Run ```Pig```

```sh
pig
```

### Local Mode:
```sh
pig -x local
```

### MapReduce Mode:
```sh
pig
```
or 
```sh
pig -x mapreduce
```



[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)
