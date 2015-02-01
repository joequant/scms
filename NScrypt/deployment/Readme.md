# Installing a devbox using Vagrant

## Installing a local devbox

- Install [Vagrant](https://www.vagrantup.com/) and Ansible (brew install ansible). 
- In deployment copy config.yml.sample to config.yml
- Edit config.yml, add your username and password (note: that's the password hash, not the cleartext password)
- Add a line to your /etc/hosts:  

    192.168.242.242 nscrypt
    
- in the NScrypt directory, run 'vagrant up'
- ssh nscrypt
- $nscrypt> cd nscrypt
- $nscrypt> bundle install
- $nscrupt> rails server -b 0.0.0.0

## Installing on a remote server

- TBD

