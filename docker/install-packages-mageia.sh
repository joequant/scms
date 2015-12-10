#!/bin/sh
urpmi --no-recommends --no-md5sum --excludedocs --auto \
      apache ruby-bundler ruby-devel gcc ruby-io-console \
      sqlite3-devel zlib-devel libxml2-devel make nodejs \
      apache apache-mod_proxy apache-mod_ssl \
      python-pip python-pillow python-yaml \
      python-dateutil python-pytz

