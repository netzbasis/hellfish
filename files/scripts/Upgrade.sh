#!/bin/sh
cd "$1" &&
echo "moving kernel" &&
cp bsd.mp /nbsd &&
ln -f /bsd /obsd &&
cp bsd /bsd.sp &&
cp bsd.rd /bsd.rd &&
mv /nbsd /bsd &&
echo "extracting base system" &&
for file in *.tgz
do
	echo "tar: $file"
	tar -zxphf $file -C /
	[ $? -gt 0 ] && exit 1
done 
echo "running MAKEDEV" &&
cd /dev &&
./MAKEDEV all &&
echo "running sysmerge" &&
sysmerge &&
echo "upgrade complete. restart your system now."
exit 0
