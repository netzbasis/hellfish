#!/bin/sh -e
echo "moving kernel"
cp bsd.mp /nbsd
ln -f /bsd /obsd
cp bsd /bsd.sp
cp bsd.rd /bsd.rd
mv /nbsd /bsd
echo "extracting base system"
for file in *.tgz
do
	echo "untar: $file"
	tar -zxphf $file -C /
done 
echo "running MAKEDEV"
cd /dev
./MAKEDEV all
echo "running sysmerge"
sysmerge
echo "upgrade complete. restart your system now."

