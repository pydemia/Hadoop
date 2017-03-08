[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)



# Easy Install

* ssh
* samba

## SU Password
```sh
sudo passwd root
```
## Create Group for HADOOP User

```sh
sudo useradd -U hadoop
sudo usermod -g hadoop [username]
```

## IP change(Install: Internet with ```enp0s3```)
```sh
sudo vi /etc/network/interfaces
```

```sh
auto enp0s3
iface enp0s3 inet dhcp


auto enp0s8
iface enp0s8 inet static
address 192.168.56.101
netmask 255.255.255.0
```


```sh
sudo vi /etc/resolv.conf

#My ROUTER IP
nameserver 131.121.45.1
#Google DNS Server
nameserver 8.8.8.8
```

and

```sh
sudo /etc/init.d/networking restart
sudo service networking restart
```
In many cases, This will works better. 
```sh
shutdown -r now
```

---
## Install JAVA

```sh
sudo apt-get update
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
java -version

sudo apt-get install default-jdk # alternavitives

vi ~/.bashrc

export JAVA_HOME=/usr/lib/jvm/java-8-oracle
```

## Setup IP alias
```sh
sudo vi /etc/hosts

127.0.0.1         localhost

192.168.56.101     hdc-namenode-0
#192.168.56.102     hdc-namenode-1

192.168.56.111     hdc-datanode-0
192.168.56.112     hdc-datanode-1
192.168.56.113     hdc-datanode-2
#192.168.56.114     hdc-datanode-3
```

## Setup SSH Server

```sh
sudo apt-get install openssh-server
ssh-keygen -t rsa -P ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

## Configuring Key Based Login

```sh
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hdc-namenode-0
#ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hdc-namenode-1
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hdc-datanode-0
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hdc-datanode-1
ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hdc-datanode-2
#ssh-copy-id -i ~/.ssh/id_rsa.pub hadoop@hdc-datanode-3
#chmod 0600 ~/.ssh/authorized_keys

```

## Prepare DataNode (Clone VM to IMPORT)

```sh
vboxmanage startvm hdc-master-0 --type headless
vboxmanage startvm hdc-slave-0 --type headless
vboxmanage startvm hdc-slave-1 --type headless
vboxmanage startvm hdc-slave-2 --type headless

```


## Change Hostname

```sh
sudo vi /etc/hostname
sudo vi /etc/network/interfaces
```

## Establish `ssh` Connections

```sh
ssh hadoop@192.168.56.101
ssh hadoop@192.168.56.111
ssh hadoop@192.168.56.112
ssh hadoop@192.168.56.113
```

## Install Hadoop with Ambari

```
sudo wget -nv http://public-repo-1.hortonworks.com/ambari/ubuntu14/2.x/updates/2.4.1.0/ambari.list -O /etc/apt/sources.list.d/ambari.list

sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD

sudo apt-get update 
sudo apt-get install ambari-server -y

sudo ambari-server setup -s
sudo ambari-server start

```
## Port Forwarding (to vm)

```sh
sudo apt-get install openssh-server
```

check `hostname`

```sh
vi /etc/hostname
vi /etc/hosts
```

UFW Setting

```sh
sudo ufw enable
sudo ufw status verbose
shdo ufw show raw

sudo ufw allow <port>/<optional: protocol>
sudo ufw allow 22/tcp
sudo ufw allow 8080/tcp

sudo ufw allow from <ip address>
```


```sh
10.0.2.15
```
| service | port |
| :-----: | :--: |
| ambari | 8080 |




[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)
