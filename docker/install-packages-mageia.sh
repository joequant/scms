#!/bin/sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
urpmi --no-recommends --no-md5sum --excludedocs --auto \
      apache ruby-bundler ruby-devel gcc ruby-io-console \
      sqlite3-devel zlib-devel libxml2-devel make nodejs \
      apache apache-mod_proxy apache-mod_ssl \
      apache-mod_proxy_html apache-mod_php \
      python-pip python-pillow python-yaml \
      python-dateutil python-pytz gnupg \
      python-virtualenv jpeg-devel python-devel \
      apache-mod_perl gitweb php-phar php-zip mongodb-server \
      wget java-headless

pushd /var/www/html
ln -sf ../../../home/user/git/gitlist .
rm index.html
ln -sf ../../../$SCRIPT_DIR/index.html .
popd

mkdir -p ~user/tmp
pushd ~user/tmp
wget -nv http://archive.apache.org/dist/lucene/solr/5.3.1/solr-5.3.1.tgz
#tar xvf solr-5.3.1.tgz solr-5.3.1/bin/install_solr_service.sh --strip-components=2
cp $SCRIPT_DIR/install_solr_service.sh .
./install_solr_service.sh solr-5.3.1.tgz
popd
mkdir -p /var/solr/data/
chmod a+w /var/solr/data/

pushd /home/user/git/gitlist
chmod a+rw cache
su user -c "php -r \"readfile('https://getcomposer.org/installer');\" | php"
su user -c "cp ../scms/docker/gitlist-config.ini config.ini"
popd




mkdir -p /var/log/allura
chown user /var/log/allura
npm install -g broccoli-cli
