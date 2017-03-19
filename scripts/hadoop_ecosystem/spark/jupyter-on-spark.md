# Jupyter On Spark

## Install Scala

```sh
cd ~
wget http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.rpm
sudo yum install scala-2.11.8.rpm
sudo yum install git
git clone https://github.com/alexarchambault/jupyter-scala.git

wget http://dl.bintray.com/sbt/rpm/sbt-0.13.5.rpm
sudo yum localinstall sbt-0.13.5.rpm
cd jupyter-scala
sbt cli/packArchive
./jupyter-scala
jupyter kernelspec list
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
cd /usr/hdp/current/spark-client/bin
vi spark-submit

# disable randomized hash for string in Python 3.3+
#export PYTHONHASHSEED=0

```

```sh
conda install jupyter

```

## Install `Apache Toree`

```sh
pip install -i https://pypi.anaconda.org/hyoon/simple toree

su root
cd /usr/hdp/current
ln -s hadoop-client hadoop
jupyter toree install --python_exec=python2 --spark_home=/usr/hdp/current/spark-client --interpreters=Scala,PySpark,SparkR,SQL --spark_opts='--master=local[0]'
```

```sh
--user
    Install to the per-user kernel registry
--debug
    set log level to logging.DEBUG (maximize logging output)
--replace
    Replace any existing kernel spec with this name.
--sys-prefix
    Install to Python's sys.prefix. Useful in conda/virtual environments.
--interpreters=<Unicode> (ToreeInstall.interpreters)
    Default: 'Scala'
    A comma separated list of the interpreters to install. The names of the
    interpreters are case sensitive.
--toree_opts=<Unicode> (ToreeInstall.toree_opts)
    Default: ''
    Specify command line arguments for Apache Toree.
--python_exec=<Unicode> (ToreeInstall.python_exec)
    Default: 'python'
    Specify the python executable. Defaults to "python"
--kernel_name=<Unicode> (ToreeInstall.kernel_name)
    Default: 'Apache Toree'
    Install the kernel spec with this name. This is also used as the base of the
    display name in jupyter.
--log-level=<Enum> (Application.log_level)
    Default: 30
    Choices: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
    Set the log level by value or name.
--config=<Unicode> (JupyterApp.config_file)
    Default: ''
    Full path of a config file.
--spark_home=<Unicode> (ToreeInstall.spark_home)
    Default: '/usr/local/spark'
    Specify where the spark files can be found.
--spark_opts=<Unicode> (ToreeInstall.spark_opts)
    Default: ''
    Specify command line arguments to proxy for spark config.

```


## Config `jupyter`

```sh
jupyter notebook --generate-config
vi ~/.jupyter/jupyter_notebook_config.py 
```

```sh
#c.NotebookApp.ip = '218.147.254.216'
c.NotebookApp.ip = '192.168.56.101'
c.NotebookApp.notebook_dir = '/home/pydemia/workspaces'
c.NotebookApp.open_browser = False
c.NotebookApp.password = 'sha1:0d1e45b9fc8a:f273120e6f60c73e4337af53fae237e6a30b2557'
c.NotebookApp.port = 5511
c.NotebookApp.port_retries = 50
c.KernelManager.autorestart = True

```
