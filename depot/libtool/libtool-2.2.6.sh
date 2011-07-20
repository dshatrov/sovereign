PACKAGE_NAME="libtool"
PACKAGE_VERNAME="libtool-2.2.6"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}a.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make -j 2
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

