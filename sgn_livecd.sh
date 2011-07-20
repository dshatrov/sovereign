#!/bin/bash

SGN_INITRD_TARGET="$1"
if [ -z "$SGN_INITRD_TARGET" ]; then
    echo "sgn_livecd.sh: initrd target not specified"
    exit 1
fi

SGN_LIVECD_TARGET="$2"
if [ -z "$SGN_LIVECD_TARGET" ]; then
    echo "sgn_livecd.sh: LiveCD target not specified"
    exit 1
fi

if [ -z "$SGN_HOME" ]; then
    echo "sgn_livecd.sh: SGN_HOME is not set"
    exit 1
fi

. "$SGN_HOME/depot/sgn/common.source.sh"
if [ $? != 0 ]; then
    echo "sgn_livecd.sh: failed to import sgn/common.source.sh"
    exit 1
fi

sgn_carefully pushd "$SGN_HOME/livecd"
sgn_carefully "$SGN_HOME/livecd/new_initrd.sh"
sgn_carefully "$SGN_HOME/livecd/new_livecd.sh"
sgn_carefully popd

sgn_carefully "$SGN_HOME/sgn_target.sh" "$SGN_INITRD_TARGET" install_initrd
sgn_carefully "$SGN_HOME/sgn_target.sh" "$SGN_LIVECD_TARGET" install_livecd

sgn_carefully "$SGN_HOME/livecd/strip_initrd.sh"

sgn_carefully "$SGN_HOME/livecd/make_initrd.sh"

sgn_carefully "$SGN_HOME/livecd/mkcdrom.sh"

