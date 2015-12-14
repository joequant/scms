#!/bin/bash
/usr/sbin/httpd 
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
rm /home/user/git/scms/NScrypt/tmp/pids/server.pid
su user -c $SCRIPT_DIR/../run.sh

