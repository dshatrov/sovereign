PACKAGE_NAME="libxml2"
PACKAGE_VERNAME="libxml2-2.6.30"

PACKAGE_ARCHIVE="libxml2-sources-2.6.30.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --with-threads
sgn_carefully sgn_builddir sgn_byuser make -j 2
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

