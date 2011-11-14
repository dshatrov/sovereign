PACKAGE_NAME="gst-ffmpeg"
PACKAGE_VERNAME="gst-ffmpeg-0.10.13"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2

sgn_carefully sgn_builddir sgn_byuser sh -c "cat gst-libs/ext/libav/configure | grep -v 'Werror=' > gst-libs/ext/libav/configure.new"
sgn_carefully sgn_builddir sgn_byuser mv gst-libs/ext/libav/configure.new gst-libs/ext/libav/configure
sgn_carefully sgn_builddir sgn_byuser chmod a+x gst-libs/ext/libav/configure

sgn_carefully sgn_builddir sgn_byuser_script "patch -p1 < \"$SGN_HOME/depot/gst-ffmpeg/gst-ffmpeg-0.10.11.2_gcc.patch\""

# 11.07.20 Had to add _GNU_SOURCE for the thing to build.
sgn_carefully sgn_builddir sgn_byuser sh -c "CFLAGS=\"\$CFLAGS -D_GNU_SOURCE\" ./configure --prefix=\"$SGN_PREFIX\" --enable-orc"
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

