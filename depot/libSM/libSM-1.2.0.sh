PACKAGE_NAME="libSM"
PACKAGE_VERNAME="libSM-1.2.0"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --enable-tcp-transport --enable-unix-transport --enable-ipv6 --enable-local-transport --without-libuuid --disable-docs
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

