#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp $SCRIPT_DIR/development.ini $SCRIPT_DIR/../../allura/Allura
cd $SCRIPT_DIR/../../allura
virtualenv env-allura
source env-allura/bin/activate
pip install -r requirements.txt
pip uninstall ForgeSVN
./rebuild-all.bash
npm install
npm run build
cp -R solr_config/allura/ /var/solr/data/


