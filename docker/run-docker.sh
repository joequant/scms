#!/bin/bash

IMAGE=nscrypt
if [ "$1" != "" ] ; then
   IMAGE=$1
fi

IMAGEDIR=$HOME/volumes/$IMAGE

mkdir -p $IMAGEDIR
pushd $IMAGEDIR

if [ ! -e $IMAGEDIR/home ] ; then
# This will fail on docker < 1.8
id=$($SUDO docker create $IMAGE)
$SUDO docker cp $id:/home - | tar xf -
$SUDO docker rm -v $id
fi


if [ ! -e $IMAGEDIR/var/log ] ; then
mkdir -p var/log
chmod a+rwx var/log
$SUDO docker run \
-v $IMAGEDIR/var:/mnt \
$IMAGE \
cp -a -P -R /var/log /mnt
fi

if [ ! -e $IMAGEDIR/etc ] ; then
mkdir -p etc
chmod a+rwx etc
$SUDO docker run \
-v $IMAGEDIR:/mnt \
$IMAGE \
cp -a -P -R /etc /mnt
fi

$SUDO docker run \
--privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v $IMAGEDIR/home:/home \
-v $IMAGEDIR/etc:/etc \
-p 80:80 -p 8000:8000 -p 8080:8080 -p 3000:3000 $IMAGE &
echo "Docker started"

