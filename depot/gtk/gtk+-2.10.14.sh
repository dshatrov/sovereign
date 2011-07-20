PACKAGE_NAME="gtk"
PACKAGE_VERNAME="gtk+-2.10.14"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make -j 2
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

