#!/bin/bash

if [ -z "$SGN_HOME" ]; then
    echo "livecd/strip_initrd.sh: SGN_HOME is not set"
    exit 1
fi

. "$SGN_HOME/depot/sgn/common.source.sh"
if [ $? != 0 ]; then
    echo "livecd/strip_initrd.sh: failed to import sgn/common.source.sh"
    exit 1
fi

if [ -z "$SGN_LIVECD_DIR" ]; then
    echo "livecd/strip_initrd.sh: \$SGN_LIVECD_DIR is not set"
    exit 1
fi

if [ -z "$SGN_PREFIX" ]; then
    echo "livecd/strip_initrd.sh: \$SGN_PREFIX is not set"
    exit 1
fi

SGN_INITRD="$SGN_LIVECD_DIR/initrd"

pushd "$SGN_INITRD"

strip_fs () {
    pushd bin
    find | xargs strip -s
    popd

    pushd sbin
    find | xargs strip -s
    popd

    pushd lib
    mv udev ..
    find | xargs strip -s
    mv ../udev ./
    find -name "*.a" | xargs rm
    find -name "*.o" | xargs rm
    popd

    if [ -d "i686-pc-linux-gnu/bin" ]; then
	pushd i686-pc-linux-gnu/bin
	find | xargs strip -s
	popd
    fi

    rm -rf info
}

strip_fs

pushd "$SGN_INITRD/$SGN_PREFIX"
strip_fs

rm -rf share/info
rm -rf man
rm -rf include

popd

popd

