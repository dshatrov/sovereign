PACKAGE_NAME="x264"
PACKAGE_VERNAME="x264-latest"

PACKAGE_ARCHIVE="last_x264.tar.bz2"

PACKAGE_DIR="last_x264"
sgn_carefully sgn_untar_bz2

sgn_carefully cd "${SGN_BUILD_DIR}"
PACKAGE_DIR=`ls -d x264*`

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --enable-shared --enable-pic
sgn_carefully sgn_builddir sgn_byuser make #-j 2
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

