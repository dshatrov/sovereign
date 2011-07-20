#!/bin/bash

if [ -z "$SGN_HOME" ]; then
    echo "SGN_HOME is not set"
    exit 1
fi

SGN_TARGET=$1
if [ -z "$SGN_TARGET" ]; then
    echo "Target not specified"
    exit 1
fi

SGN_ACTION=$2
if [ -z "$SGN_ACTION" ]; then
    echo "Action not specified"
    exit 1
fi

SGN_STARTING_FROM=$3

. "$SGN_HOME/depot/sgn/common.source.sh"
if [ $? != 0 ]; then
    echo "sgn_target.sh: could not import depot/sgn/common.source.sh"
    exit 1
fi

sgn_test_flag ()
{
    local LINE="$1"
    local FLAG="$2"
    if echo "$LINE" |
	grep "\\(^\\|[ \\t]\\+\\)${FLAG}\\([ \\t]\\+\\|\$\\)" > /dev/null;
    then
	return 0
    fi

    return 1
}

if [ -z "$SGN_STARTING_FROM" ]; then
    SGN_STARTED=1
else
    SGN_STARTED=0
fi

cat "$SGN_TARGET" |
    while read LINE; do
	if [ -z "$LINE" ]; then
	    continue;
	fi

	if echo $LINE | grep '^[ \t]*#' > /dev/null; then
	    continue;
	fi

	SGN_TMP="$LINE"
	SGN_NAME="`echo $SGN_TMP | sed 's/\([^ \t]\+\).*/\1/'`"

	SGN_TMP="`echo $SGN_TMP     | sed 's/[^ \t]\+\(.*\)/\1/'`"
	SGN_VERSION="`echo $SGN_TMP | sed 's/\([^ \t]\+\).*/\1/'`"

	SGN_TMP="`echo $SGN_TMP   | sed 's/[^ \t]\+\(.*\)/\1/'`"
	SGN_FLAGS="`echo $SGN_TMP | sed 's/\([^ \t]\+\).*/\1/'`"

	if [ "$SGN_STARTED" = 0 ]; then
	    if [ "$SGN_STARTING_FROM" = "$SGN_NAME" ]; then
		SGN_STARTED=1
	    else
		if [ "$SGN_STARTING_FROM" = "$SGN_VERSION" ]; then
		    SGN_STARTED=1
		else
		    continue
		fi
	    fi
	fi

	echo "Name:    $SGN_NAME"
	echo "Version: $SGN_VERSION"
	echo "Flags:   $SGN_FLAGS"

	sgn_carefully cd "$SGN_HOME"
	case "$SGN_ACTION" in
	make)
	    sgn_carefully ./sgn_make.sh "depot/$SGN_NAME/$SGN_VERSION.sh"
	    ;;
	make_livecd)
	    sgn_carefully ./sgn_make.sh "depot/$SGN_NAME/$SGN_VERSION.sh" "$SGN_LIVECD_PREFIX" ".livecd"
	    ;;
	install)
	    if ! sgn_test_flag "$SGN_FLAGS" "script"; then
		sgn_carefully ./sgn_install.sh "$SGN_SGN_DIR/$SGN_VERSION.sgn"
	    else
		sgn_carefully ./sgn_make.sh "depot/$SGN_NAME/$SGN_VERSION.sh"
	    fi
	    ;;
	make_install)
	    sgn_carefully ./sgn_make.sh "depot/$SGN_NAME/$SGN_VERSION.sh"
	    if ! sgn_test_flag "$SGN_FLAGS" "script"; then
		sgn_carefully ./sgn_install.sh "$SGN_SGN_DIR/$SGN_VERSION.sgn"
	    fi
	    ;;
	make_install_livecd)
	    sgn_carefully ./sgn_make.sh "depot/$SGN_NAME/$SGN_VERSION.sh" "$SGN_LIVECD_PREFIX" ".livecd"
	    if ! sgn_test_flag "$SGN_FLAGS" "script"; then
		sgn_carefully ./sgn_install.sh "$SGN_SGN_DIR/$SGN_VERSION.livecd.sgn" "$SGN_LIVECD_PREFIX"
	    fi
	    ;;
	install_initrd)
	    if ! sgn_test_flag "$SGN_FLAGS" "root"; then
		sgn_carefully pushd "$SGN_LIVECD_DIR/initrd/$SGN_PREFIX"
	    else
		sgn_carefully pushd "$SGN_LIVECD_DIR/initrd/"
	    fi
	    sgn_carefully tar xzf "$SGN_SGN_DIR/$SGN_VERSION.sgn"
	    sgn_carefully popd
	    ;;
	install_livecd)
	    if ! sgn_test_flag "$SGN_FLAGS" "root"; then
		sgn_carefully pushd "$SGN_LIVECD_DIR/livecd/$SGN_LIVECD_PREFIX"
	    else
		sgn_carefully pushd "$SGN_LIVECD_DIR/livecd/"
	    fi
	    sgn_carefully tar xzf "$SGN_SGN_DIR/$SGN_VERSION.livecd.sgn"
	    sgn_carefully popd
	    ;;
	*)
	    echo "Unknown action"
	    exit 1
	esac
    done

