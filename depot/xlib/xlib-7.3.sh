build_package () {
    sgn_carefully sgn_untar_bz2 "$SOURCE_DIR/$PACKAGE_ARCHIVE"

    sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
    sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS

    sgn_install_begin_nocleanup
    sgn_carefully sgn_builddir make install
    sgn_install_end_nocleanup

    # This time we install into "$SGN_PREFIX".
    # This is necessary because latter xlib* packages may depend on the current one.
    sgn_carefully sgn_builddir make install

    sgn_carefully sgn_byuser rm -rf "$SGN_BUILD_DIR/$PACKAGE_DIR"
}

SOURCE_DIR="xorg/7.3/lib"

sgn_install_cleanup

cat "$SGN_HOME/depot/xlib/xlib_compilation_order" |
    while read LINE
    do
	echo "LINE: $LINE"

	if [ -z "$LINE" ]
	then
	    continue;
	fi

	local _GOT_PACKAGE="0"
	sgn_carefully cd "$SGN_SRC_DIR/$SOURCE_DIR"
	for PACKAGE_ARCHIVE in *.tar.bz2
	do
	    PACKAGE_VERNAME=`echo "$PACKAGE_ARCHIVE" | sed 's/\.tar\.bz2$//'`
	    PACKAGE_NAME=`echo "$PACKAGE_VERNAME" | sed 's/-[^-]*$//'`
	    PACKAGE_DIR="${PACKAGE_VERNAME}"

	    echo "$PACKAGE_NAME vs $LINE"

	    if [ "$PACKAGE_NAME" = "$LINE" ]
	    then
		build_package
		_GOT_PACKAGE="1"
		break
	    fi
	done

	if [ "$_GOT_PACKAGE" = "0" ]; then
	    echo "ERROR: No source tarball for $LINE"
	    exit 1
	fi
    done

if [ $? != 0 ]
then
    exit 1
fi

BUNDLE_VERNAME=xlib-7.3

sgn_install_begin_nocleanup
sgn_carefully cd "$SGN_INSTALL"
sgn_carefully tar czf "$SGN_SGN_DIR/${BUNDLE_VERNAME}${SGN_PACKAGE_SUFFIX}.sgn" *
sgn_carefully cd "$SGN_HOME"

sgn_carefully sgn_install_end

sgn_finstat "$BUNDLE_VERNAME"

