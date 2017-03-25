[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)


# Hadoop Setting - 0.VM Setting

### Global Network Setting  

* NAT Networks for Internet ```enp0s3```  
* Host-only Networks for Inner connection ```enp0s8```  
> Disable ```DHCP Server```  
> ```Adapter```, Set IPv4 Address as ```Gateway``` for Static IP:(```192.168.56.1```)

### Set Each Machine Before Install

* Adapter 1 ```NAS```  
* Adapter 2 ```Host-only Adapter```  


### Port forwarding



If VM is off:
```sh
VBoxManage modifyvm "hdc-master-0" --natpf1 "guestssh,tcp,,2222,10.0.2.15,22"

```


If VM is on:
```sh
VBoxManage controlyvm "hdc-master-0" --natpf1 "guestssh,tcp,,2222,10.0.2.15,22"

```


[← back to *Main Page*](https://github.com/dawkiny/Hadoop/blob/master/README.md)
