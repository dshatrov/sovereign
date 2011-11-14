PACKAGE_NAME="libsoup"
PACKAGE_VERNAME="libsoup-2.37.1"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --without-gnome --disable-more-warnings
#sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --without-gnome --disable-glibtest

#sgn_carefully sgn_builddir sgn_byuser sh -c "LD_LIBRARY_PATH=\"$SGN_PREFIX/lib:$LD_LIBRARY_PATH\" ./configure --prefix=\"$SGN_PREFIX\" --without-gnome"

sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

