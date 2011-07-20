PACKAGE_NAME="speex"
PACKAGE_VERNAME="speex-1.2rc1"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make -j 2
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

