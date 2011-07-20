#!/bin/bash

if [ -z "$SGN_HOME" ]; then
    echo "livecd/new_initrd.sh: SGN_HOME is not set"
    exit 1
fi

. "$SGN_HOME/depot/sgn/common.source.sh"
if [ $? != 0 ]; then
    echo "livecd/new_initrd.sh: failed to import sgn/common.source.sh"
    exit 1
fi

if [ -z "$SGN_LIVECD_DIR" ]; then
    echo "livecd/new_initrd.sh: \$SGN_LIVECD_DIR is not set"
    exit 1
fi

SGN_INITRD="$SGN_LIVECD_DIR/initrd"

sgn_carefully sgn_byuser mkdir -p "$SGN_INITRD"

sgn_carefully sgn_cleanup_dir "$SGN_INITRD"

# Preparing directories
sgn_carefully mkdir -pv "$SGN_INITRD"/{dev,proc,sys}
sgn_carefully mkdir -pv "$SGN_INITRD"/dev/{pts,shm}
sgn_carefully chmod 0777 "$SGN_INITRD/dev/shm"
sgn_carefully chmod +t "$SGN_INITRD/dev/shm"
sgn_carefully mknod -m 600 "$SGN_INITRD"/dev/console c 5 1
sgn_carefully mknod -m 666 "$SGN_INITRD"/dev/null c 1 3

sgn_carefully mkdir -pv "$SGN_INITRD"/{bin,boot,etc/opt,home,lib,mnt,opt}
sgn_carefully mkdir -pv "$SGN_INITRD"/{media/{floppy,cdrom},sbin,srv,var}
sgn_carefully install -dv -m 0750 "$SGN_INITRD/root"
sgn_carefully install -dv -m 1777 "$SGN_INITRD/tmp" "$SGN_INITRD/var/tmp"
sgn_carefully mkdir -pv "$SGN_INITRD"/usr/{,local/}{bin,include,lib,sbin,src}
sgn_carefully mkdir -pv "$SGN_INITRD"/usr/{,local/}share/{doc,info,locale,man}
sgn_carefully mkdir -v  "$SGN_INITRD"/usr/{,local/}share/{misc,terminfo,zoneinfo}
sgn_carefully mkdir -pv "$SGN_INITRD"/usr/{,local/}share/man/man{1..8}
for dir in "$SGN_INITRD/usr" "$SGN_INITRD/usr/local"; do
    sgn_carefully ln -sv share/{man,doc,info} $dir
done
sgn_carefully mkdir -v "$SGN_INITRD"/var/{lock,log,mail,run,spool}
sgn_carefully mkdir -pv "$SGN_INITRD"/var/{opt,cache,lib/{misc,locate},local}

# Creating essential symbolic links
sgn_carefully ln -sv "$SGN_PREFIX"/bin/{bash,cat,echo,grep,pwd,stty} "$SGN_INITRD/bin"
sgn_carefully ln -sv "$SGN_PREFIX"/bin/perl "$SGN_INITRD/usr/bin"
sgn_carefully ln -sv "$SGN_PREFIX"/lib/libgcc_s.so{,.1} "$SGN_INITRD/usr/lib"
sgn_carefully ln -sv "$SGN_PREFIX"/lib/libstdc++.so{,.6} "$SGN_INITRD/usr/lib"
if [ ! -e "$SGN_INITRD/bin/sh" ]; then
    sgn_carefully ln -sv bash "$SGN_INITRD/bin/sh"
fi

sgn_carefully ln -s "$SGN_PREFIX/etc/udev" "$SGN_INITRD/etc/udev"

# TEST LINES!
#mkdir -p "$SGN_INITRD/opt/sgn/etc/udev/rules.d"
#sgn_carefully cp "/etc/udev/rules.d/60-symlinks.rules" "$SGN_INITRD/opt/sgn/etc/udev/rules.d/"

sgn_carefully touch "$SGN_INITRD/etc/mtab"

sgn_carefully cp "$SGN_HOME/livecd/tmpl/passwd" "$SGN_INITRD/etc/passwd"
sgn_carefully cp "$SGN_HOME/livecd/tmpl/group" "$SGN_INITRD/etc/group"

sgn_carefully touch "$SGN_INITRD/var/run/utmp" "$SGN_INITRD"/var/log/{btmp,lastlog,wtmp}
sgn_carefully chgrp -v utmp "$SGN_INITRD/var/run/utmp" "$SGN_INITRD/var/log/lastlog"
sgn_carefully chmod -v 664 "$SGN_INITRD/var/run/utmp" "$SGN_INITRD/var/log/lastlog"

sgn_carefully cp "$SGN_HOME/livecd/tmpl/inputrc" "$SGN_INITRD/etc/inputrc"
sgn_carefully cp "$SGN_HOME/livecd/tmpl/hosts" "$SGN_INITRD/etc/hosts"

sgn_carefully cp "$SGN_HOME/livecd/tmpl/linuxrc" "$SGN_INITRD/linuxrc"
sgn_carefully cp "$SGN_HOME/livecd/tmpl/linuxrc" "$SGN_INITRD/init"
sgn_carefully mkdir -p "$SGN_INITRD/sbin"
sgn_carefully cp "$SGN_HOME/livecd/tmpl/linuxrc" "$SGN_INITRD/sbin/init"

sgn_carefully cp "$SGN_HOME/livecd/tmpl/start.sh" "$SGN_INITRD/start.sh"

sgn_carefully mkdir -p "$SGN_INITRD/$SGN_PREFIX"

