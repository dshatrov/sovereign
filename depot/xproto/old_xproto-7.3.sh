build_package () {
    sgn_carefully sgn_untar_bz2 "$SOURCE_DIR/$PACKAGE_ARCHIVE"

    sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
    sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS

    sgn_install_begin_nocleanup
    sgn_carefully sgn_builddir make install
    sgn_install_end_nocleanup

    sgn_carefully sgn_byuser rm -rf "$SGN_BUILD_DIR/$PACKAGE_DIR"
}

SOURCE_DIR="xorg/7.3/proto"
UNPACK_COMMAND="tar xjf"

sgn_install_cleanup

sgn_carefully cd "$SGN_SRC_DIR/$SOURCE_DIR"
for PACKAGE_ARCHIVE in *.tar.bz2
do
    PACKAGE_VERNAME=`echo "$PACKAGE_ARCHIVE" | sed 's/\.tar\.bz2$//'`
    PACKAGE_NAME=`echo "$PACKAGE_VERNAME" | sed 's/-[^-]*$//'`
    PACKAGE_DIR="${PACKAGE_VERNAME}"

    build_package
done

BUNDLE_VERNAME=xproto-7.3

sgn_install_begin_nocleanup
sgn_carefully cd "$SGN_INSTALL"
sgn_carefully tar czf "$SGN_SGN_DIR/${BUNDLE_VERNAME}${SGN_PACKAGE_SUFFIX}.sgn" *
sgn_carefully cd "$SGN_HOME"

sgn_install_end

sgn_finstat "$BUNDLE_VERNAME"

