PACKAGE_NAME="pixman"
PACKAGE_VERNAME="pixman-0.12.0"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make
sgn_carefully sgn_builddir sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

