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




mkdir hadoop_dir/data   # Separate Node data against push_bash.sh
mkdir hadoop_dir/logs   # Separate Node logs against push_bash.sh
mkdir hadoop_dir/ids    # Separate Node PID or something against push_bash.sh
```


scp -r /usr/local/hadoop_eco dawkiny@hd0m2:/usr/local
scp -r /usr/local/hadoop_eco dawkiny@hd0s1:/usr/local
scp -r /usr/local/hadoop_eco dawkiny@hd0s2:/usr/local
scp -r /usr/local/hadoop_eco dawkiny@hd0s3:/usr/local
scp -r /usr/local/hadoop_eco dawkiny@hd0s4:/usr/local

#
