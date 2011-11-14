PACKAGE_NAME="gst-plugins-bad"
PACKAGE_VERNAME="gst-plugins-bad_11-11-10"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser sh -c "cat configure | sed 's/opencv <= 2.2.0//g' > configure.new"
sgn_carefully sgn_builddir sgn_byuser mv configure.new configure
sgn_carefully sgn_builddir sgn_byuser chmod a+x configure

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --disable-examples --disable-librfb --enable-opencv
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

