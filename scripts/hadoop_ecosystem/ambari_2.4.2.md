# Ambari Setting

## Download & Build Ambari Source

```sh
mkdir ~/hadoop_downloads
cd ~/hadoop_downloads
wget http://apache.mirror.cdnetworks.com/ambari/ambari-2.4.2/apache-ambari-2.4.2-src.tar.gz
tar xfvz apache-ambari-2.4.2-src.tar.gz
cd apache-ambari-2.4.2-src
```

Install ```Maven```
```sh
sudo apt-get install maven
```

```sh
sudo mvn versions:set -DneVersion=2.4.2.0.0
 
pushd ambari-metrics
sudo mvn versions:set -DnewVersion=2.4.2.0.0
popd

sudo mvn -B clean install package jdeb:jdeb -DnewVersion=2.4.2.0.0 -DskipTests -Dpython.ver="python >= 2.6"
```

## Install Ambari Server

```sh
sudo apt-get update
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
sudo apt-get install ambari-server*.deb   #This should also pull in postgres packages as well.
```

In case 
>E: Unable to locate package ambari-server*.deb
>E: Couldn't find any package by glob 'ambari-server*.deb'
>E: Couldn't find any package by regex 'ambari-server*.deb'

Then 
```sh
sudo apt-get clean 
cd /var/lib/apt 
sudo mv lists lists.old 
sudo mkdir -p lists/partial 
sudo apt-get clean 
sudo apt-get update
```
