#!/bin/bash

SGN_SCRIPT="$1"
if [ -z "$SGN_SCRIPT" ]; then
    echo "sgn/make.sh: script not scpecified"
    exit 1
fi

SGN_ALTERNATE_PREFIX="$2"
SGN_PACKAGE_SUFFIX="$3"

if [ -z "$SGN_HOME" ]; then
    echo "SGN_HOME is not set"
    exit 1
fi

. "$SGN_HOME/depot/sgn/common.source.sh"
if [ $? != 0 ]; then
    echo "sgn/make.sh: failed to include sgn/common.source.sh"
    exit 1
fi

sgn_setenv

source $SGN_SCRIPT

