PACKAGE_NAME="glibc"
PACKAGE_VERNAME="glibc-2.7"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2

sgn_carefully cd "$SGN_BUILD_DIR"
sgn_carefully sgn_byuser rm -rf "glibc-build"
sgn_carefully sgn_byuser mkdir "glibc-build"

sgn_carefully cd "glibc-build"

#sgn_carefully sgn_byuser_script "echo \"CFLAGS += -march=i486 -g -O2\" > configparms"
sgn_carefully sgn_byuser_script "echo \"CFLAGS += -march=i486\" > configparms"
sgn_carefully sgn_byuser_script "../glibc-2.7/configure --prefix=\"$SGN_PREFIX\" --enable-add-ons --enable-kernel=2.6.0 --without-selinux --with-headers=\"$SGN_PREFIX/include\" --without-gd --with-binutils=\"$SGN_PREFIX/bin\""
sgn_carefully sgn_byuser make -j 2

sgn_carefully sgn_install_begin
sgn_carefully mkdir -p "$SGN_PREFIX/etc"
sgn_carefully touch "$SGN_PREFIX/etc/ld.so.conf"
sgn_carefully make install
sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_carefully sgn_byuser rm -rf "$SGN_BUILD_DIR/glibc-build"

sgn_cleanup
sgn_finstat

