#!/bin/bash

if [ -z "$SGN_HOME" ]; then
    echo "livecd/mkcdrom.sh: SGN_HOME is not set"
    exit 1
fi

. "$SGN_HOME/depot/sgn/common.source.sh"
if [ $? != 0 ]; then
    echo "livecd/mkcdrom.sh: failed to import sgn/common.source.sh"
    exit 1
fi

if [ -z "$SGN_LIVECD_DIR" ]; then
    echo "livecd/mkcdrom.sh: \$SGN_LIVECD_DIR is not set"
    exit 1
fi

sgn_carefully ln "$SGN_LIVECD_DIR/initrd.gz" "$SGN_LIVECD_DIR/livecd/boot/initrd.gz"

sgn_carefully mkisofs -R -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -boot-info-table -o "$SGN_LIVECD_DIR/livecd.iso" "$SGN_LIVECD_DIR/livecd"

