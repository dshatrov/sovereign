PACKAGE_NAME="openssl"
PACKAGE_VERNAME="openssl-1.0.0d"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./config --prefix="$SGN_PREFIX" shared zlib-dynamic
sgn_carefully sgn_builddir sgn_byuser make
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

