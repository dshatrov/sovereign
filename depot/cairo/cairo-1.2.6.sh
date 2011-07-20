PACKAGE_NAME="cairo"
PACKAGE_VERNAME="cairo-1.2.6"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser_script "patch -p1 < \"$SGN_SRC_DIR/${PACKAGE_NAME}/cairo-1.2.6_ctype_h_patch\""
sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make -j 2
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

