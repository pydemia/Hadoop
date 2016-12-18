# Set up Zookeeper

## Install Zookeeper packages automatically
```sh
sudo apt-get update
sudo apt-get install zookeeper zookeeperd
```


* In case your locale is not set properly:
```sh
LANGUAGE = (unset),
LC_ALL = (unset)
```
Then
```sh
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```


* In case you meet
```sh
adduser: Warning: The home directory `/var/lib/zookeeper' does not belong to the user you are currently creating.
update-alternatives: using /etc/zookeeper/conf_example to provide /etc/zookeeper/conf (zookeeper-conf) in auto mode
```
Then
```sh
sudo chown -R dawkiny:hadoop /etc/zookeeper
sudo chown -R dawkiny:hadoop /var/lib/zookeeper

sudo mkdir /usr/local/hadoop_eco/zookeeper
sudo chown -R [username]:hadoop /usr/local/hadoop_eco/zookeeper
mv -r /etc/zookeeper /usr/local/hadoop_eco/zookeeper/
```


### Zookeeper Configuration
```sh
vi /etc/zookeeper/conf/zoo.cfg
```

```sh
# specify all zookeeper servers
# The fist port is used by followers to connect to the leader
# The second one is used for leader election
server.1=hd0m1:2888:3888
server.2=hd0m2:2888:3888
server.3=hd0s1:2888:3888
server.4=hd0s2:2888:3888
server.5=hd0s3:2888:3888
server.6=hd0s4:2888:3888
autopurge.snapRetainCount=10
autopurge.purgeInterval=12
```

```sh
vi ~/.bashrc
```

```sh
# Zookeeper
export ZOOKEEPER_HOME=/zookeeper
export ZOOKEEPER_PREFIX=$ZOOKEEPER_HOME
export ZOO_LOG_DIR=/usr/local/hadoop_log/zookeeper/logs
PATH=$ZOOKEEPER_HOME/bin:$PATH
```




---
## Install Zookeeper packages manually

### Standby to Each Server

Create ```hadoop_eco``` folder on Each Server to use it as a path of fully-covered hadoop ecosystem
```sh
sudo mkdir /usr/local/hadoop_eco
sudo chown -R dawkiny:hadoop /usr/local/hadoop_eco
sudo chown -R [username]:hadoop /usr/local/hadoop_eco
```

* In case your locale is not set properly:
```sh
LANGUAGE = (unset),
LC_ALL = (unset)
```
Then
```sh
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

### Download & Install Zookeeper From the first server

```sh
cd /usr/local/hadoop_eco
wget http://apache.tt.co.kr/zookeeper/stable/zookeeper-3.4.9.tar.gz  # Check first http://apache.tt.co.kr/zookeeper/stable/
tar zxvf zookeeper-3.4.9.tar.gz
mv zookeeper-3.4.9/ zookeeper
```

### Zookeeper Configuration

### Create ```dataDir```
```sh
cd /usr/local/hadoop_dat
mkdir -p /usr/local/hadoop_datzookeeper/data
```

### Create ```zoo.cfg```
```sh
cp zoo_sample.cfg zoo.cfg   # Create zoo.cfg from zoo_sample.cfg
vi zoo.cfg
```


```sh
# the directory where the snapshot is stored.
# do not use /tmp for storage, /tmp here is just 
# example sakes.
dataDir=/usr/local/hadoop_dat/zookeeper/data


# specify all zookeeper servers
# The fist port is used by followers to connect to the leader
# The second one is used for leader election
server.1=hd0m1:2888:3888
server.2=hd0m2:2888:3888
server.3=hd0s1:2888:3888
server.4=hd0s2:2888:3888
server.5=hd0s3:2888:3888
server.6=hd0s4:2888:3888
autopurge.snapRetainCount=10
autopurge.purgeInterval=12
```


### Copy ```hadoop_eco``` to Each Server

```sh 
scp -r /usr/local/hadoop_eco [username]@hd0m2:/usr/local
scp -r /usr/local/hadoop_eco [username]@hd0s1:/usr/local
scp -r /usr/local/hadoop_eco [username]@hd0s2:/usr/local
scp -r /usr/local/hadoop_eco [username]@hd0s3:/usr/local
scp -r /usr/local/hadoop_eco [username]@hd0s4:/usr/local
```
## Create ```myid``` file to Each Server

On Master:
```sh
cd /usr/local/hadoop_dat/zookeeper/data

scp -r /usr/local/hadoop_dat/zookeeper/data dawkiny@hd0m2:/usr/local/hadoop_dat
scp -r /usr/local/hadoop_dat/zookeeper/data dawkiny@hd0s1:/usr/local/hadoop_dat
scp -r /usr/local/hadoop_dat/zookeeper/data dawkiny@hd0s2:/usr/local/hadoop_dat
scp -r /usr/local/hadoop_dat/zookeeper/data dawkiny@hd0s3:/usr/local/hadoop_dat
scp -r /usr/local/hadoop_dat/zookeeper/data dawkiny@hd0s4:/usr/local/hadoop_dat

echo 1 > /usr/local/hadoop_dat/zookeeper/data/myid
ssh dawkiny@hd0m2 "echo 2 > /usr/local/hadoop_dat/zookeeper/data/myid"
ssh dawkiny@hd0s1 "echo 3 > /usr/local/hadoop_dat/zookeeper/data/myid"
ssh dawkiny@hd0s2 "echo 4 > /usr/local/hadoop_dat/zookeeper/data/myid"
ssh dawkiny@hd0s3 "echo 5 > /usr/local/hadoop_dat/zookeeper/data/myid"
ssh dawkiny@hd0s4 "echo 6 > /usr/local/hadoop_dat/zookeeper/data/myid"
```

### Update ```.bashrc``` & Run ```zookeeper```

```sh
vi ~/.bashrc
```

```sh
# Zookeeper
export ZOOKEEPER_HOME=/usr/local/hadoop_eco/zookeeper
export ZOOKEEPER_PREFIX=$ZOOKEEPER_HOME
export ZOO_LOG_DIR=/usr/local/hadoop_log/zookeeper/logs
export PATH=$PATH:$ZOOKEEPER_HOME/bin
```

```sh
scp -r ~/.bashrc dawkiny@hd0m2:~/
scp -r ~/.bashrc dawkiny@hd0s1:~/
scp -r ~/.bashrc dawkiny@hd0s1:~/
scp -r ~/.bashrc dawkiny@hd0s2:~/
scp -r ~/.bashrc dawkiny@hd0s3:~/
scp -r ~/.bashrc dawkiny@hd0s4:~/

# re-run .bashrc on Each Server
source ~/.bashrc
ssh dawkiny@hd0m2 "source ~/.bashrc"
ssh dawkiny@hd0s1 "source ~/.bashrc"
ssh dawkiny@hd0s2 "source ~/.bashrc"
ssh dawkiny@hd0s3 "source ~/.bashrc"
ssh dawkiny@hd0s4 "source ~/.bashrc"

zkServer.sh start
ssh dawkiny@hd0m2 "/usr/local/hadoop_eco/zookeeper/bin/zkServer.sh start"    
ssh dawkiny@hd0s1 "/usr/local/hadoop_eco/zookeeper/bin/zkServer.sh start" 
ssh dawkiny@hd0s2 "/usr/local/hadoop_eco/zookeeper/bin/zkServer.sh start" 
ssh dawkiny@hd0s3 "/usr/local/hadoop_eco/zookeeper/bin/zkServer.sh start" 
ssh dawkiny@hd0s4 "/usr/local/hadoop_eco/zookeeper/bin/zkServer.sh start" 
zkServer.sh stop
zkServer.sh start
jps                  # QuorumPeerMain : Zookeeper daemon
```


## Access ```zookeeper``` 

```sh
zkCli.sh -server hd0m1:2181
```

## Stop ```zookeeper```

On Each Server:
```sh
zkServer.sh stop
```

## Clean-up SnapShots

On Each Server:
```sh
zkCleanup.sh
```
