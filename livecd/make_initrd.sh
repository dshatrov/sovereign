#!/bin/bash

if [ -z "$SGN_HOME" ]; then
    echo "livecd/make_initrd.sh: SGN_HOME is not set"
    exit 1
fi

. "$SGN_HOME/depot/sgn/common.source.sh"
if [ $? != 0 ]; then
    echo "livecd/make_initrd.sh: failed to import sgn/common.source.sh"
    exit 1
fi

if [ -z "$SGN_LIVECD_DIR" ]; then
    echo "livecd/make_initrd.sh: \$SGN_LIVECD_DIR is not set"
    exit 1
fi

sgn_carefully sgn_byuser mkdir -p "$SGN_LIVECD_DIR/initrd"

# !!! TEST
#sgn_carefully cp "/etc/udev/rules.d/50-udev.rules" "$SGN_LIVECD_DIR/initrd/$SGN_PREFIX/etc/udev/rules.d/"

sgn_carefully pushd "$SGN_LIVECD_DIR/initrd"
#sgn_carefully_script "find . | cpio -H newc --create | gzip -9 > \"$SGN_LIVECD_DIR/initrd.gz\""
sgn_carefully_script "find . | cpio -H newc --create | gzip -1 > \"$SGN_LIVECD_DIR/initrd.gz\""
sgn_carefully popd

