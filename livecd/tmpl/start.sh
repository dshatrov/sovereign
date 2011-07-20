#rm -rf /tmp/*
#rm -rf /tmp/.*

SGN_PREFIX="/opt/sgn"

# TODO /opt/sgn hard-coded
export PATH="$SGN_PREFIX/sbin:$SGN_PREFIX/bin:/usr/sbin:/usr/bin:/sbin:/bin"
#export PATH=$PATH:/opt/xorg/bin:/opt/gtk/bin:/opt/mync/bin:/opt/fvwm/bin:/opt/icewm/bin
#export LD_LIBRARY_PATH=/opt/xorg/lib:/opt/gtk/lib:/opt/mync/lib:/opt/icewm/lib
#ldconfig

mount -t proc none /proc
mount -t tmpfs none /dev/shm
mount -t sysfs none /sys
mount -t devpts none /dev/pts

mount -t tmpfs none /tmp

mount -o mode=0755 -t tmpfs none /dev
cp -a -f "$SGN_PREFIX/lib/udev/devices"/* /dev

ip addr add 127.0.0.1/8 dev lo
ip link set lo up

echo "Detecting devices"

echo "" > /proc/sys/kernel/hotplug
udevd --daemon
udevtrigger
udevsettle

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!! DEBUG
echo 'First test point'
/bin/bash --login

if [ ! -b /dev/cdrom ]; then
	echo "Could not find CD-ROM";
	exit -1;
fi

echo "Mounting CD-ROM"

mount -o ro -t iso9660 /dev/cdrom /mnt/livecd
if (( $? )); then
	echo "Failed to mount CD-ROM";
	exit -1;
fi

if [ ! -d /mnt/livecd/usr ] || [ ! -d /mnt/livecd/opt ]; then
	echo "Mounted disk is not a MyNC LiveCD";
	exit -1;
fi

mount --bind /mnt/livecd/usr /usr
mount --bind /mnt/livecd/opt /opt

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!! DEBUG
echo 'Second test point'
/bin/bash --login

export HOME=/root
cd $HOME

echo Starting MyNC

mount -t tmpfs none /root/mync
cp /root/gmync/* /root/mync/

cd /root/mync
if (grep mync_vesa /proc/cmdline); then
	cp /root/xorg.conf.vesa ./xorg.conf
else
	touch xorg.conf.new
	X -configure -logfile /dev/null
	cat xorg.conf.new | sed -n "/Section \"Screen\"/ { q }; p" > xorg.conf
	cat /root/xorg.screen >> xorg.conf
fi

cd /root/mykernel
./insert.sh
cd /root/mync
nice -n -19 myncbd daemon

xinit -- -dpi 96 -config /root/mync/xorg.conf -logfile /dev/null
#/bin/bash --login

kill `ps | grep "myncbd" | sed "s/[ ]*//; s/ .*$//; q"`

cd /root/mykernel
./rm.sh

echo **************************
echo Thank you for trying MyNC.
echo **************************
echo
echo Press Ctrl+D to reboot
echo
cat
reboot

