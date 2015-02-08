### From a fresh new Install of Ubuntu
### Log in as root
apt-get update
apt-get install curl
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -L https://get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
rvm requirements
rvm install ruby
rvm use ruby --default
rvm rubygems current
#apt-get install ruby-dev
#apt-get install ruby1.9.1-dev
#apt-get install make
gem install rails

apt-get install git-core

### One user must run
bundle install

### reboot!!!

### Adding user
/usr/sbin/visudo

adduser $USER
mkdir /home/$USER/.ssh
echo $PUB_KEY > /home/$USER/.ssh/authorized_keys
chmod 700 /home/$USER/.ssh/authorized_keys