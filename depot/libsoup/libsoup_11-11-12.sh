PACKAGE_NAME="libsoup"
PACKAGE_VERNAME="libsoup_11-11-12"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser sh -c "patch -p1 < \"$SGN_HOME/depot/libsoup/libsoup_thread-context.patch\""

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --without-gnome --disable-more-warnings

sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

