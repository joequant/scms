#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $SCRIPT_DIR/../mayan-edms
source env-mayan/bin/activate
mayan-edms.py runserver &
deactivate
popd
pushd $SCRIPT_DIR/../allura
source env-allura/bin/activate
paster setup-app Allura/development.ini
gunicorn --reload --paste Allura/development.ini --daemon
deactivate
popd
pushd $SCRIPT_DIR/NScrypt
./bin/rails server --binding=0.0.0.0
popd


