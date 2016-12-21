


# Set up ```Tez```

## Check ```Hadoop``` version
Check & change ```Hadoop``` version in the top-level ```pom.xml``` to match the version of the ```Hadoop``` branch being used.
```sh
hadoop version
```

## Install Requirements
You might have already installed ```JDK6``` or later.

Install ```Maven3``` or later.

```sh
sudo apt-get install maven
```


Install ```protobuf 2.5``` or later.
```sh
wget https://github.com/google/protobuf/archive/v2.5.0.tar.gz
mv v2.5.0.tar.gz protobuf-v2.5.0.tar.gz 
tar -zxf protobuf-v2.5.0.tar.gz 
mv protobuf-2.5.0 protobuf
cd protobuf
sudo ./configure
sudo make
sudo make check
sudo make install
```

or
```sh
sudo apt-get install protobuf-compiler 
sudo apt-get install protobuf-c-compiler 
```



