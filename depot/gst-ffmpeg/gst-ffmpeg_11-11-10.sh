PACKAGE_NAME="gst-ffmpeg"
PACKAGE_VERNAME="gst-ffmpeg_11-11-10"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser_script "patch -p1 < \"$SGN_HOME/depot/gst-ffmpeg/gst-ffmpeg-0.10.11.2_gcc.patch\""
# 11.07.20 Had to add _GNU_SOURCE for the thing to build.
sgn_carefully sgn_builddir sgn_byuser sh -c "CFLAGS=\"\$CFLAGS -D_GNU_SOURCE\" ./configure --prefix=\"$SGN_PREFIX\" --enable-orc"
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

