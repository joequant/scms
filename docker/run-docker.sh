#!/bin/bash

IMAGE=nscrypt
if [ "$1" != "" ] ; then
   IMAGE=$1
fi

mkdir -p ~/volumes/$IMAGE
pushd ~/volumes/$IMAGE

if [ ! -e ~/volumes/$IMAGE/home ] ; then
# This will fail on docker < 1.8
id=$($SUDO docker create $IMAGE)
$SUDO docker cp $id:/home - | tar xf -
$SUDO docker rm -v $id
fi


if [ ! -e ~/volumes/$IMAGE/var/log ] ; then
mkdir -p var/log
chmod a+rwx var/log
$SUDO docker run \
-v ~/volumes/$IMAGE/var:/mnt \
$IMAGE \
cp -a -P -R /var/log /mnt
fi

if [ ! -e ~/volumes/$IMAGE/etc ] ; then
mkdir -p etc
chmod a+rwx etc
$SUDO docker run \
-v ~/volumes/$IMAGE:/mnt \
$IMAGE \
cp -a -P -R /etc /mnt
fi

$SUDO docker run \
--privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v ~/volumes/$IMAGE/home:/home \
-v ~/volumes/$IMAGE/etc:/etc \
-p 3000:3000 $IMAGE &
echo "Docker started"

