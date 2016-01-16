#!/bin/bash
su mongod -s "/bin/bash" -c "/usr/bin/mongod --quiet -f /etc/mongod.conf" &
/usr/sbin/httpd 
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
rm /home/user/git/scms/NScrypt/tmp/pids/server.pid
service solr start
su user -c $SCRIPT_DIR/../run.sh

