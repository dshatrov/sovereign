PACKAGE_NAME="util-linux-ng"
PACKAGE_VERNAME="util-linux-ng-2.18"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --without-ncurses
sgn_carefully sgn_builddir sgn_byuser make
sgn_carefully sgn_builddir sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

