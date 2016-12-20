#------------Hadoop Directory Management------------#

#####################################################
# NameNode
#####################################################

## Create Directory

sudo mkdir /usr/local/hadoop_eco
sudo mkdir /usr/local/hadoop_dat
sudo mkdir /usr/local/hadoop_log
sudo mkdir /usr/local/hadoop_var

# Change Permission

sudo chown -R dawkiny:hadoop /usr/local/hadoop_eco
sudo chown -R dawkiny:hadoop /usr/local/hadoop_dat
sudo chown -R dawkiny:hadoop /usr/local/hadoop_log
sudo chown -R dawkiny:hadoop /usr/local/hadoop_var


#####################################################
# NameNode
#####################################################

array=(hd0m2 hd0s1 hd0s2 hd0s3 hd0s4)

for i in "${array[@]}"

do
        # Create Directory
        
        ssh dawkiny@$i "sudo mkdir /usr/local/hadoop"
        ssh dawkiny@$i "sudo mkdir /usr/local/hadoop_eco"
        ssh dawkiny@$i "sudo mkdir /usr/local/hadoop_dat"
        ssh dawkiny@$i "sudo mkdir /usr/local/hadoop_log"
        ssh dawkiny@$i "sudo mkdir /usr/local/hadoop_var"
        
        # Change Permission
        
        ssh dawkiny@$i "sudo chown -R dawkiny:hadoop /usr/local/hadoop"
        ssh dawkiny@$i "sudo chown -R dawkiny:hadoop /usr/local/hadoop_eco"
        ssh dawkiny@$i "sudo chown -R dawkiny:hadoop /usr/local/hadoop_dat"
        ssh dawkiny@$i "sudo chown -R dawkiny:hadoop /usr/local/hadoop_log"
        ssh dawkiny@$i "sudo chown -R dawkiny:hadoop /usr/local/hadoop_var"

done
