yum install -y deltarpm
yum install -y docker git epel-release
yum install -y python34
yum upgrade -y
systemctl enable docker
systemctl start docker

