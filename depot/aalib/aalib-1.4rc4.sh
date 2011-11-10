PACKAGE_NAME="aalib"
PACKAGE_VERNAME="aalib-1.4.0"

PACKAGE_ARCHIVE="aalib-1.4rc4.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --with-x11-driver=no --without-x
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

