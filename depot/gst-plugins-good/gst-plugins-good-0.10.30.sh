PACKAGE_NAME="gst-plugins-good"
PACKAGE_VERNAME="gst-plugins-good-0.10.30"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2

# Proof-of-concept patch. It's not really correct and can't be used in production.
#sgn_carefully sgn_builddir sgn_byuser sh -c "patch -p1 < \"$SGN_HOME/depot/gst-plugins-good/gst-plugins-good-0.10.30_soup.patch\""

sgn_carefully sgn_builddir sgn_byuser sh -c "patch -p1 < \"$SGN_HOME/depot/gst-plugins-good/gst-plugins-good-0.10.30_libsoup-release.patch\""

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --disable-examples --disable-gconftool --disable-gconf --disable-esd --disable-libcaca --disable-gdk_pixbuf --disable-cairo
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

