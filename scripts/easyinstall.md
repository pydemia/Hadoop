[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)

# Server Setting

IP:
```sh
192.168.56.101  hdc-master-0  hdc-master-0.hdc.com
192.168.56.111  hdc-slave-0   hdc-slave-0.hdc.com
192.168.56.112  hdc-slave-1   hdc-slave-1.hdc.com
192.168.56.113  hdc-slave-2   hdc-slave-2.hdc.com
```

Username:

* root
* pydemia

## SU Password
```sh
sudo passwd root
```


## Setup IP alias
```sh
vi /etc/hosts

127.0.0.1         localhost

192.168.56.101     hdc-master-0
#192.168.56.102     hdc-master-1

192.168.56.111     hdc-slave-0
192.168.56.112     hdc-slave-1
192.168.56.113     hdc-slave-2
#192.168.56.114     hdc-slave-3
```

## IP change(Install: Internet with ```enp0s3```)

### Ubuntu:
```sh
vi /etc/network/interfaces
```

```sh
auto eth0
iface eth0 inet dhcp


auto eth1
iface eth1 inet static
address 192.168.56.101
netmask 255.255.255.0
```

Restart network

```sh
/etc/init.d/networking restart
service networking restart
```
In many cases, This will works better. 
```sh
shutdown -r now
```

### CentOS:

```sh
vi /etc/sysconfig/network-scripts/ifcfg-enp0s3
```

```sh

```

```sh
vi /etc/sysconfig/network-scripts/ifcfg-enp0s8
```

```sh
TYPE=Ethernet
#BOOTPROTO=dhcp
BOOTPROTO=static
DEFROUTE=YES
PEERDNS=yes
PEERROUTES=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=no
IPV6_AUTOCONF=no
IPV6_DEFROUTE=yes
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=enp0s8
UUID=04ebee32-6a74-486f-9f88-6090dedca1b5
DEVICE=enp0s8
#ONBOOT=no
ONBOOT=yes
NM_CONTROLLED="yes"
IPADDR=192.168.56.101
GATEWAY=192.168.56.1
BROADCAST=192.168.56.255

```


Restart network

```sh
/etc/init.d/network restart
service network restart
ip addr
```

## Change Hostname

### Ubuntu:

set hostname when installed

### CentOS:

```sh
hostnamectl set-hostname hdc-master-0.hdc.com
echo hdc-master-0.hdc.com > /proc/sys/kernel/hostname
vi /etc/sysconfig/network

HOSTNAME=hdc-master-0.hdc.com
```
```sh
hostnamectl set-hostname hdc-master-0.hdc.com
hostnamectl set-hostname hdc-slave-0.hdc.com
hostnamectl set-hostname hdc-slave-1.hdc.com
hostnamectl set-hostname hdc-slave-2.hdc.com
```
192.168.56.111  hdc-slave-0   hdc-slave-0.hdc.com
192.168.56.112  hdc-slave-1   hdc-slave-1.hdc.com
192.168.56.113  hdc-slave-2   hdc-slave-2.hdc.com

---
## Configure SSH

```sh
ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

#접속확인
ssh root@hdc-master-0.hdc.com
ssh root@hdc-slave-0.hdc.com
ssh root@hdc-slave-1.hdc.com
ssh root@hdc-slave-2.hdc.com
 

scp -r /root/.ssh root@hdc-slave-0.hdc.com:/root
scp -r /root/.ssh root@hdc-slave-1.hdc.com:/root
scp -r /root/.ssh root@hdc-slave-2.hdc.com:/root
 


cat ~/.ssh/id_dsa.pub | ssh root@hdc-master-0.hdc.com 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_dsa.pub | ssh root@hdc-slave-0.hdc.com 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_dsa.pub | ssh root@hdc-slave-1.hdc.com 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_dsa.pub | ssh root@hdc-slave-2.hdc.com 'cat >> ~/.ssh/authorized_keys'

ssh root@hdc-slave-0.hdc.com 'mkdir -p ~/.ssh'
ssh root@hdc-slave-1.hdc.com 'mkdir -p ~/.ssh'
ssh root@hdc-slave-2.hdc.com 'mkdir -p ~/.ssh'


#접속확인
ssh root@hdc-master-0.hdc.com
ssh root@hdc-slave-0.hdc.com
ssh root@hdc-slave-1.hdc.com
ssh root@hdc-slave-2.hdc.com

```

## Set NTP service


CentOS:

```sh
yum install ntp
service ntpd start
chkconfig ntpd on
service --status-all | grep ntpd

```

Configure `master` as a NTP Server

```sh
vi /etc/ntp.conf:
server  127.127.1.0     # local clock
fudge   127.127.1.0 stratum 10
```

Configure `slave` as NTP Clients

```sh
vi /etc/ntp.conf
server hdc-master-0.hdc.com
```

```sh
service ntpd start
ntpq -p
ntpd -u hdc-master-0.hdc.com
```

4N-CHDC
Actually, `chrony` is better.


## Disable SELinux

CentOS:
```sh
vi /etc/selinux/config

SELINUX=disabled
```

```sh
scp /etc/selinux/config root@hdc-slave-0.hdc.com:/etc/selinux/config
scp /etc/selinux/config root@hdc-slave-1.hdc.com:/etc/selinux/config
scp /etc/selinux/config root@hdc-slave-2.hdc.com:/etc/selinux/config
```

## Disable `firewalld` and set `iptables`

```sh
systemctl stop firewalld
systemctl mask firewalld
yum install iptables-services

systemctl enable iptables
chkconfig iptables off
```




## Install JAVA

```sh
apt-get update
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java8-installer
java -version

apt-get install default-jdk # alternavitives

vi /etc/bash.bashrc

# JAVA PATH
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
```

## Setup IP alias
```sh
vi /etc/hosts

127.0.0.1         localhost

192.168.56.101     hdc-master-0
#192.168.56.102     hdc-master-1

192.168.56.111     hdc-slave-0
192.168.56.112     hdc-slave-1
192.168.56.113     hdc-slave-2
#192.168.56.114     hdc-slave-3
```

## Setup SSH Server

```sh
apt-get install openssh-server
ssh-keygen -t rsa -P ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

## Configuring Key Based Login

```sh
scp ~/.ssh/id_rsa.pub root@hd0m2:/root/.ssh

```


```sh
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub root@hdc-master-0
#ssh-copy-id -i ~/.ssh/id_rsa.pub root@hdc-master-1
ssh-copy-id -i ~/.ssh/id_rsa.pub root@hdc-slave-0
ssh-copy-id -i ~/.ssh/id_rsa.pub root@hdc-slave-1
ssh-copy-id -i ~/.ssh/id_rsa.pub root@hdc-slave-2
#ssh-copy-id -i ~/.ssh/id_rsa.pub root@hdc-slave-3
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

Ubuntu:
```
wget -nv http://public-repo-1.hortonworks.com/ambari/ubuntu14/2.x/updates/2.4.2.0/ambari.list -O /etc/apt/sources.list.d/ambari.list

apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD

apt-get update 
apt-get install ambari-server -y

ambari-server setup -s
ambari-server start

```


CentOS:

```sh
cd /etc/yum.repos.d
wget http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.4.2.0/ambari.repo
yum repolist
yum install ambari-server -y


```


## Setup Ambari

```sh
ambari-server setup
```

## Start Ambari

```sh
ambari-server start
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


## Notice

To use `ambari` on a local client outside, `/etc/hosts` file of the client should have its aliases.


[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)
