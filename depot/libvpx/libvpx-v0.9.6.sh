PACKAGE_NAME="libvpx"
PACKAGE_VERNAME="libvpx-v0.9.6"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --enable-shared
sgn_carefully sgn_builddir sgn_byuser make -j 2
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

