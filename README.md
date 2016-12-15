# Hadoop on Ubuntu

##VM Setting

### Global Network Setting  

* NAT Networks for Internet ```enp0s3```  
* Host-only Networks for Inner connection ```enp0s8```  

### Set Each Machine Before Install

* Adapter 1 ```NAS```  
* Adapter 2 ```Host-only Adapter```  

## SU Password
```sh
sudo passwd root
```

## IP change

```sh
sudo vi /etc/network/interfaces
```

```sh
auto [adaptername]
iface [adaptername] inet dhcp
```

to
```sh
iface [adaptername] inet static
address 131.121.45.11
netmask 255.255.255.0
network 131.121.45.0
gateway 131.121.45.1

dns-nameservers 168.126.63.1 168.126.63.2 8.8.8.8
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
sudo apt-get install oracle-java7-installer
java -version
```

## Setup IP alias
```sh
sudo vi /etc/hosts

127.0.0.1         localhost

131.121.45.11     hadoop-m1
131.121.45.12     hadoop-m2

131.121.45.21     hadoop-s1
131.121.45.22     hadoop-s2
131.121.45.23     hadoop-s3
131.121.45.24     hadoop-s4
```

## Setup SSH Server

```sh
apt-get install openssh-server
ssh-keygen -t rsa -P ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```



wget --no-check-certificate
