yum install -y deltarpm
yum upgrade -y
yum install -y docker git epel-release
yum install -y python34 
systemctl enable docker
systemctl start docker

