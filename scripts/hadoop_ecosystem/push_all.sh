#----------------Push to Nodes---------------#
array=(hd0m2 hd0s1 hd0s2 hd0s3 hd0s4)


source ~/.bashrc

for i in "${array[@]}"

do
        # Push .bashrc
        scp -r ~/.bashrc dawkiny@$i:~/

        ## Re-run .bashrc

        ssh dawkiny@$i "source ~/.bashrc"

        # Push Hadoop Core Settings
        scp -r /usr/local/hadoop dawkiny@$i:/usr/local/
        
        # Push Hadoop Ecosystem Settings
        scp -r /usr/local/hadoop_eco dawkiny@$i:/usr/local/

done
