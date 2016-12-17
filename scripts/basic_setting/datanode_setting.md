# Hadoop Setting - 2.DataNode

---
# Creating the DataNode

## Import cloned VM

### Change ```hostname``` of Each DataNodes

```sh
sudo vi /etc/hostname

hd0s1
```
and 
```sh
sudo reboot
```

## Adding the DataNodes in Master

```sh
cd /usr/local/hadoop/etc/hadoop
vi slaves
```

```sh
hd0s1
hd0s2
hd0s3
hd0s4
```

# Configuring the DataNode

## Install Hadoop Distribution From NameNode

### Copy Hadoop From NameNode to Each DataNode

From Each DataNode

```sh
cd /usr/local
sudo scp -r [username]@hd0s1:/usr/local/hadoop /usr/local
```

### Create Folders in Each DataNodes
```sh
sudo mkdir -p /usr/local/hadoop_work/hdfs/datanode
sudo mkdir -p /usr/local/hadoop_work/hdfs/yarn/local
sudo mkdir -p /usr/local/hadoop_work/hdfs/yarn/log

sudo chown -R [user]:hadoop /usr/local/hadoop
sudo chown -R [user]:hadoop /usr/local/hadoop_work
```
