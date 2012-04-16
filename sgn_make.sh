#!/bin/bash

SGN_SCRIPT="$1"
if [ -z "$SGN_SCRIPT" ]; then
    echo "Script not specified"
    exit 1
fi

SGN_ALTERNATE_PREFIX="$2"
SGN_PACKAGE_SUFFIX="$3"

echo "sgn_make SGN_ALTERNATE_PREFIX: $SGN_ALTERNATE_PREFIX"
echo "sgn_make SGN_PACKAGE_SUFFIX: $SGN_PACKAGE_SUFFIX"

if [ -z "$SGN_HOME" ]; then
    echo "SGN_HOME not set"
    exit 1
fi

env -i SGN_HOME="$SGN_HOME" HOME="$SGN_HOME/depot/sgn/sgn_home" TERM="$TERM" PS1='\u\w$ ' /bin/bash --rcfile "$SGN_HOME/sgn_bashrc" "$SGN_HOME/depot/sgn/make.sh" "$SGN_SCRIPT" "$SGN_ALTERNATE_PREFIX" "$SGN_PACKAGE_SUFFIX"

