PACKAGE_NAME="linux"
PACKAGE_VERNAME="linux-2.6.36.2"

# NOTE: This file does not exist!
PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser cp "$SGN_SRC_DIR/$PACKAGE_NAME/config_$PACKAGE_VERNAME" "./.config"
sgn_carefully sgn_builddir sgn_byuser make oldnoconfig
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS

sgn_carefully sgn_install_begin
sgn_carefully sgn_builddir make modules_install INSTALL_MOD_PATH="$SGN_PREFIX"
sgn_carefully mkdir -p "$SGN_PREFIX/boot"
sgn_carefully sgn_builddir cp "arch/i386/boot/bzImage" "$SGN_PREFIX/boot/image-2.6.36.2"
sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_carefully sgn_cleanup
sgn_finstat

