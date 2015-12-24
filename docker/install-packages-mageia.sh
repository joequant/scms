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
      apache-mod_perl gitweb php-phar php-zip 

pushd /var/www/html
ln -sf ../../../home/user/git/gitlist .
rm index.html
ln -sf ../../../$SCRIPT_DIR/index.html .
popd



pushd /home/user/git/gitlist
chmod a+rw cache
su user -c "php -r \"readfile('https://getcomposer.org/installer');\" | php"
su user -c "cp ../scms/docker/gitlist-config.ini config.ini"
popd







