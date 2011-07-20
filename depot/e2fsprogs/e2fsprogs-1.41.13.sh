PACKAGE_NAME="e2fsprogs"
PACKAGE_VERNAME="e2fsprogs-1.41.13"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make

sgn_carefully sgn_install_begin
sgn_carefully sgn_builddir make install
sgn_carefully sgn_builddir make install-libs
sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_carefully sgn_cleanup
sgn_finstat

