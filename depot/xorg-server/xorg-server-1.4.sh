PACKAGE_NAME="xorg"
PACKAGE_VERNAME="xorg-server-1.4"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2 "xorg/7.3/xserver/$PACKAGE_ARCHIVE"

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make
sgn_carefully sgn_builddir sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

