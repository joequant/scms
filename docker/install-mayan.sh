#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR/../../mayan-edms
pip install mayan-edms
/usr/bin/mayan-edms.py initalsetup
