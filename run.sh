#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $SCRIPT_DIR/../mayan-edms
virtualenv venv
source venv/bin/activate
mayan-edms.py runserver &
popd
pushd $SCRIPT_DIR/NScrypt
./bin/rails server --binding=0.0.0.0
popd


