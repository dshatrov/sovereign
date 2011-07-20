PACKAGE_NAME="gst-ffmpeg"
PACKAGE_VERNAME="gst-ffmpeg-0.10.11.2"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2

sgn_carefully sgn_builddir sgn_byuser_script "patch -p1 < \"$SGN_HOME/depot/gst-ffmpeg/${PACKAGE_VERNAME}_gcc.patch\""
sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make -j 2
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

