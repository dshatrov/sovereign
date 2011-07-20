PACKAGE_NAME="xbitmaps"
PACKAGE_VERNAME="xbitmaps-1.0.1"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2 "xorg/7.3/data/${PACKAGE_ARCHIVE}"

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

