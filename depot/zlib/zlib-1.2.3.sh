PACKAGE_NAME="zlib"
PACKAGE_VERNAME="zlib-1.2.3"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --shared
sgn_carefully sgn_builddir sgn_byuser make -j 2

sgn_install_begin
sgn_carefully sgn_builddir make install
sgn_install_end_nocleanup

sgn_carefully sgn_builddir sgn_byuser make clean
sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make -j 2

sgn_install_begin_nocleanup
sgn_carefully sgn_builddir make install
sgn_carefully chmod 644 "$SGN_INSTALL/lib/libz.a"

sgn_carefully sgn_prepare_package
sgn_install_end

sgn_carefully sgn_cleanup
sgn_finstat

