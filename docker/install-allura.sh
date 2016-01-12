#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR/../../allura
virtualenv env-allura
source env-allura/bin/activate
pip install -r requirements.txt
pip uninstall ForgeSVN
./rebuild-all.bash
npm install
npm run build

