# Jupyter On Spark

## Install Scala

```sh
cd ~
wget http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.rpm
sudo yum install scala-2.11.8.rpm

```

## Install Anaconda

```sh
sudo yum install scala
sudo yum install bzip2
wget https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh
DIR >> yes
PATH >> yes
source ~/.bashrc
```

## Install `jupyter`

```sh
conda install jupyter
pip install -i https://pypi.anaconda.org/hyoon/simple toree
jupyter toree install --spark_home=/usr/hdp/current/spark-client
```
