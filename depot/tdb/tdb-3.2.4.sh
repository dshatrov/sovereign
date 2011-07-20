PACKAGE_NAME="tdb"
_VERSION="3.2.4"
PACKAGE_VERNAME="tdb-$_VERSION"

PACKAGE_ARCHIVE="samba-${_VERSION}.tar.gz"
PACKAGE_DIR="samba-${_VERSION}"

sgn_carefully sgn_untar_gz "samba/$PACKAGE_ARCHIVE"

sgn_carefully pushd "$SGN_BUILD_DIR/$PACKAGE_DIR/source/lib/tdb"

    sgn_carefully sgn_byuser ./autogen.sh
    sgn_carefully sgn_byuser ./configure --prefix="$SGN_PREFIX"
    sgn_carefully sgn_byuser make

    sgn_carefully sgn_install_begin
    sgn_carefully make install
    sgn_carefully sgn_prepare_package
    sgn_carefully sgn_install_end

sgn_carefully popd

sgn_carefully sgn_cleanup
sgn_finstat

