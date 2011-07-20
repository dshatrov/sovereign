PACKAGE_NAME="binutils"
PACKAGE_VERNAME="binutils-2.18"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="$PACKAGE_VERNAME"

sgn_carefully sgn_untar_bz2

sgn_carefully sgn_builddir sgn_byuser_script "patch -p1 < \"$SGN_SRC_DIR/binutils/binutils-2.18_patches/binutils-2.18-configure-1.patch\""
sgn_carefully sgn_builddir sgn_byuser_script "CC=\"gcc -B/usr/bin/\" ./configure --prefix=\"$SGN_PREFIX\""
sgn_carefully sgn_builddir sgn_byuser make

sgn_carefully sgn_install_begin
sgn_carefully sgn_builddir make install
sgn_carefully sgn_builddir sgn_byuser make -C ld clean
sgn_carefully sgn_builddir sgn_byuser make -C ld LIB_PATH="$SGN_PREFIX/lib"
sgn_carefully sgn_builddir cp ld/ld-new "$SGN_PREFIX/bin"
sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_carefully sgn_cleanup
sgn_finstat

