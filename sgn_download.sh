#!/bin/bash

SGN_THIS="sgn_download.sh"

if [ -z "$SGN_HOME" ]; then
    echo "SGN_HOME is not set"
    exit 1
fi

SGN_DOWNLOAD_LIST=$1
if [ -z "$SGN_DOWNLOAD_LIST" ]; then
    echo "Download list not specified"
    exit 1
fi

. "$SGN_HOME/depot/sgn/common.source.sh"
if [ $? != 0 ]; then
    echo "$SGN_THIS: could not import depot/sgn/common.source.sh"
    exit 1
fi

sgn_get_first ()
{
    echo $1 | sed 's/\([^ \t]\+\).*/\1/'
}

sgn_get_rest ()
{
    echo $1 | sed 's/[^ \t]\+\(.*\)/\1/'
}

cat "$SGN_DOWNLOAD_LIST" |
    while read LINE; do
	if [ -z "$LINE" ]; then
	    continue;
	fi

	if [ -z "`echo $LINE | grep -v '^[[:space:]]*#.*'`" ]; then
	    continue;
	fi

	SGN_TMP="$LINE"
	SGN_DOWNLOAD_DIR=`sgn_get_first "$SGN_TMP"`

	SGN_TMP=`sgn_get_rest "$SGN_TMP"`
	SGN_DOWNLOAD_URL=`sgn_get_first "$SGN_TMP"`

	echo "$SGN_THIS: downloading: dir $SGN_DOWNLOAD_DIR, url $SGN_DOWNLOAD_URL"

	sgn_carefully sgn_byuser mkdir -p "$SGN_SRC_DIR/$SGN_DOWNLOAD_DIR"

	sgn_carefully pushd "$SGN_SRC_DIR/$SGN_DOWNLOAD_DIR"
	sgn_carefully sgn_byuser wget -c "$SGN_DOWNLOAD_URL"
	sgn_carefully popd
    done

