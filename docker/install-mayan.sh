#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR/../../mayan-edms
virtualenv venv
source venv/bin/activate
pip install .
mayan-edms.py initialsetup
