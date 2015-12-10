#!/bin/bash
/usr/sbin/httpd 
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
su user -c $SCRIPT_DIR/../run.sh
