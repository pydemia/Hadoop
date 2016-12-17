# Set up Ambari

```sh
cd /etc/apt/sources.list.d
```

```sh
sudo wget http://public-repo-1.hortonworks.com/ambari/ubuntu14/2.x/updates/2.2.2.0/ambari.list
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
sudo apt-get update
sudo apt-get install ambari-server
```

```sh
sudo ambari-server setup
```
> Using python  /usr/bin/python  
> Setup ambari-server  
> Checking SELinux...  
> WARNING: Could not run /usr/sbin/sestatus: OK  
> Ambari-server daemon is configured to run under user 'dawkiny'. Change this setting [y/n] (n)? y  
> Enter user account for ambari-server daemon (root):dawkiny  
> Adjusting ambari-server permissions and ownership...  
> Checking firewall status...  
> Checking JDK...  
> Do you want to change Oracle JDK [y/n] (n)? y  
> [1] Oracle JDK 1.8 + Java Cryptography Extension (JCE) Policy Files 8  
> [2] Oracle JDK 1.7 + Java Cryptography Extension (JCE) Policy Files 7  
> [3] Custom JDK  
> ==============================================================================  
> Enter choice (1): 2  
> JDK already exists, using /var/lib/ambari-server/resources/jdk-7u67-linux-x64.tar.gz  
> Installing JDK to /usr/jdk64/  
> Successfully installed JDK to /usr/jdk64/  
> JCE Policy archive already exists, using /var/lib/ambari-server/resources/UnlimitedJCEPolicyJDK7.zip  
> Installing JCE policy...  
> Completing setup...  
> Configuring database...  
> Enter advanced database configuration [y/n] (n)? y  
> Configuring database...  
> ==============================================================================  
> Choose one of the following options:  
> [1] - PostgreSQL (Embedded)  
> [2] - Oracle  
> [3] - MySQL  
> [4] - PostgreSQL  
> [5] - Microsoft SQL Server (Tech Preview)  
> [6] - SQL Anywhere  
> ==============================================================================  
> Enter choice (3): 1  
> Database name (adb): adb  
> Postgres schema (adb): adb  
> Username (ambari): ambari  
> Enter Database Password (data):   
> Default properties detected. Using built-in database.  
> Configuring ambari database...  
> Checking PostgreSQL...  
> About to start PostgreSQL  
> Configuring local database...  
> Connecting to local database...done.  
> Configuring PostgreSQL...  
> Extracting system views...  
> .......  
> Adjusting ambari-server permissions and ownership...  
> Ambari Server 'setup' completed successfully.  





```sh
sudo ambari-server start
```

Default ```username``` and ```password``` : admin / admin
