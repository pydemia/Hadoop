[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)


# Hadoop Directory Management

## Create Directory
```sh
cd ~/
sudo mkdir /usr/local/hadoop_eco
sudo mkdir /usr/local/hadoop_dat
sudo mkdir /usr/local/hadoop_log
sudo mkdir /usr/local/hadoop_var
sudo chown -R dawkiny:hadoop /usr/local/hadoop_eco
sudo chown -R dawkiny:hadoop /usr/local/hadoop_dat
sudo chown -R dawkiny:hadoop /usr/local/hadoop_log
sudo chown -R dawkiny:hadoop /usr/local/hadoop_var


mkdir /usr/local/hadoop        # Share Hadoop Core settings among the nodes
mkdir /usr/local/hadoop_eco    # Share Hadoop Ecosystem settings
mkdir /usr/local/hadoop_dat    # Separate each Node data against push_all.sh
mkdir /usr/local/hadoop_log    # Separate each Node logs against push_all.sh
mkdir /usr/local/hadoop_var    # Separate each Node PIDs or some variables against push_all.sh
```


scp -r /usr/local/hadoop_eco dawkiny@hd0m2:/usr/local
scp -r /usr/local/hadoop_eco dawkiny@hd0s1:/usr/local
scp -r /usr/local/hadoop_eco dawkiny@hd0s2:/usr/local
scp -r /usr/local/hadoop_eco dawkiny@hd0s3:/usr/local
scp -r /usr/local/hadoop_eco dawkiny@hd0s4:/usr/local


[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)
