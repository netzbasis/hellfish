#!/bin/sh

RDSIZE=92160	#45MB
WDIR=./hf_work
SDIR=$PWD

mkdir $WDIR
doas rm -rf $WDIR/*

cd $WDIR
mkdir root
echo extracting base
doas tar -zxphf ../tmp/last/base*.tgz -C root
doas tar -zxphf ../tmp/last/comp*.tgz -C root
doas tar -zxphf ../tmp/last/man*.tgz -C root
doas tar -zxphf ../tmp/last/game*.tgz -C root
doas tar -zxphf ../tmp/last/xbase*.tgz -C root
doas tar -zxphf ../tmp/last/xfont*.tgz -C root
doas tar -zxphf ../tmp/last/xserv*.tgz -C root
doas tar -zxphf ../tmp/last/xshare*.tgz -C root

dd if=/dev/zero of=rd.raw bs=512 count=$RDSIZE
#dd if=/dev/zero of=usb.raw bs=1M count=1024	#1GB

doas vnconfig vnd3 rd.raw
printf "a a\n\n\n\nw\nq\n" | doas disklabel -E vnd3
doas disklabel vnd3
doas newfs -g 64 vnd3a
doas mount /dev/vnd3a /mnt
cd root
doas cp -a bin dev etc home mnt root sbin tmp /mnt/.
cd /mnt
doas mkdir var
doas mkdir usr
doas chmod 755 var
doas chmod 755 usr
cd /mnt/dev
doas sh ./MAKEDEV all 
cd $SDIR
pwd
doas umount /mnt
doas vnconfig -u vnd3
