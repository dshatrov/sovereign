PACKAGE_NAME="gst-plugins-bad"
PACKAGE_VERNAME="gst-plugins-bad-0.10.22"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2

sgn_carefully sgn_builddir sgn_byuser sh -c "patch -p1 < \"$SGN_HOME/depot/gst-plugins-bad/gst-plugins-bad-0.10.22_h264parse.patch\""

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --disable-examples --disable-librfb
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

