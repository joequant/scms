# Installing a devbox using Vagrant

## Overview

NScrypt is installed on Ubuntu 14.04 using Ansible.
For development, Vagrant is used to start a VirtualBox VM. The source code directory is mapped from your host PC to the VM ($HOME/nscrypt).
The IP address of the Virtual box VM is 192.168.242.242


## Installing a local devbox

- Install [Vagrant](https://www.vagrantup.com/) and Ansible (brew install ansible). 
- In NScrypt/deployment copy config.yml.sample to config.yml
- Edit config.yml, add your username and password (note: that's the password hash, not the cleartext password)
- Add a line to your /etc/hosts:  

    192.168.242.242 nscrypt
    
- in the NScrypt directory, run 'vagrant up'
- ssh nscrypt
- $nscrypt> cd nscrypt
- $nscrypt> bundle install
- $nscrupt> rails server -b 0.0.0.0

## Installing on a remote server

- Install Ansible on your PC (brew install ansible)
- Create an inventory file. This is a text file with the name of the remote server (such that  ssh <remote-server-name> works).
- On your local PC, cd to NScrypt/deployment
- run 'ansible-playbook -K -i<path to inventoryfile> playbook.yml'

