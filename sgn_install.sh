#!/bin/bash

SGN_BASEDIR=`pwd`

SGN_PACKAGE=$1
if [ -z "$SGN_PACKAGE" ]; then
    echo "Package not specified"
    exit 1
fi

SGN_ALTERNATE_PREFIX=$2

echo $SGN_PACKAGE | grep '^/' > /dev/null
if [ $? != 0 ]; then
    SGN_PACKAGE="$SGN_BASEDIR/$SGN_PACKAGE"
fi

if [ -z "$SGN_HOME" ]; then
    echo "\$SGN_HOME is not set"
    exit 1
fi

. "$SGN_HOME/depot/sgn/common.source.sh"
if [ $? != 0 ]; then
    echo "sgn_install.sh: failed to import sgn/common.source.sh"
    exit 1
fi

sgn_carefully pushd "$SGN_PREFIX"
sgn_carefully tar xzvf "$SGN_PACKAGE"
sgn_carefully popd

