PACKAGE_NAME="util-linux-ng"
PACKAGE_VERNAME="util-linux-ng-2.13.1"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make
sgn_carefully sgn_builddir sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

