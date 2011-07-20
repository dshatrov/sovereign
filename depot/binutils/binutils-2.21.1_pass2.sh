PACKAGE_NAME="binutils"
PACKAGE_VERNAME="binutils-2.21.1"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully cd "$SGN_BUILD_DIR"
sgn_carefully sgn_byuser rm -rf "binutils-build"
sgn_carefully sgn_byuser mkdir "binutils-build"

# Timestamp bug workaround
#sgn_carefully cd "$SGN_BUILD_DIR"
#sgn_carefully sgn_byuser mkdir -p "binutils-build/bfd/doc"
#sgn_carefully sgn_byuser ln -s "../../../${PACKAGE_VERNAME}/bfd/doc/elf.texi" "binutils-build/bfd/doc/"
# (End of timestamp bug workaround)

sgn_carefully cd "$SGN_BUILD_DIR/binutils-build"
sgn_carefully sgn_byuser "../$PACKAGE_DIR/configure" --prefix="$SGN_PREFIX" --with-lib-path="$SGN_PREFIX/lib"
sgn_carefully sgn_byuser "make"

sgn_carefully sgn_install_begin
sgn_carefully make install
sgn_carefully sgn_prepare_package "${PACKAGE_VERNAME}_pass2"
sgn_carefully sgn_install_end

sgn_carefully cd "$SGN_BUILD_DIR"
sgn_carefully sgn_byuser rm -rf "binutils-build"

sgn_carefully sgn_cleanup
sgn_finstat "${PACKAGE_VERNAME}_pass2"

