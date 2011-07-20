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

SGN_LIVECD="$SGN_LIVECD_DIR/livecd"

sgn_carefully sgn_byuser mkdir -p "$SGN_LIVECD"

sgn_carefully sgn_cleanup_dir "$SGN_LIVECD"

sgn_carefully mkdir -pv "$SGN_LIVECD/boot/grub"

sgn_carefully cp "$SGN_HOME/livecd/tmpl/stage2_eltorito" "$SGN_LIVECD/boot/grub"
sgn_carefully cp "$SGN_HOME/livecd/tmpl/menu.lst" "$SGN_LIVECD/boot/grub"

sgn_carefully mkdir -p "$SGN_LIVECD/$SGN_LIVECD_PREFIX"

