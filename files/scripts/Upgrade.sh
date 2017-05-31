#!/bin/sh -e
echo "moving kernel"
cmp -s bsd.mp /bsd || ln -f /bsd /obsd
cp bsd.mp /nbsd
cp bsd /bsd.sp
cp bsd.rd /bsd.rd
mv /nbsd /bsd
echo "extracting base system"
cp /sbin/reboot /sbin/oreboot
for file in [!b]*.tgz base*.tgz
do
	echo "untar: $file"
	tar -zxphf $file -C /
done 
echo "running MAKEDEV"
cd /dev
./MAKEDEV all
echo "running sysmerge"
sysmerge
echo "upgrade complete. restart your system now. (/sbin/oreboot)"
echo "maybe run: installboot, sysmerge, cd /dev && ./MAKEDEV, fw_update, pkg_add -u"
