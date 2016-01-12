#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $SCRIPT_DIR/../mayan-edms
source env-mayan/bin/activate
mayan-edms.py runserver &
source env-mayan/bin/deactivate
popd
source env-allura/bin/activate
paster setup-app development.ini
gunicorn --reload --paste development.ini --daemon
source env-allura/bin/deactivate
popd
pushd $SCRIPT_DIR/NScrypt
./bin/rails server --binding=0.0.0.0
popd


