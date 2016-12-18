# Push .bashrc
scp -r ~/.bashrc dawkiny@hd0m2:~/
scp -r ~/.bashrc dawkiny@hd0s1:~/
scp -r ~/.bashrc dawkiny@hd0s2:~/
scp -r ~/.bashrc dawkiny@hd0s3:~/
scp -r ~/.bashrc dawkiny@hd0s4:~/

## Re-run .bashrc
source ~/.bashrc
ssh dawkiny@hd0m2 "source ~/.bashrc"
ssh dawkiny@hd0s1 "source ~/.bashrc"
ssh dawkiny@hd0s2 "source ~/.bashrc"
ssh dawkiny@hd0s3 "source ~/.bashrc"
ssh dawkiny@hd0s4 "source ~/.bashrc"


# Push Haddop Ecosystem Folder
scp -r /usr/local/hadoop_eco dawkiny@hd0m2:/usr/local/
scp -r /usr/local/hadoop_eco dawkiny@hd0s1:/usr/local/
scp -r /usr/local/hadoop_eco dawkiny@hd0s2:/usr/local/
scp -r /usr/local/hadoop_eco dawkiny@hd0s3:/usr/local/
scp -r /usr/local/hadoop_eco dawkiny@hd0s4:/usr/local/

