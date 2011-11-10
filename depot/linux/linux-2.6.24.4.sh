PACKAGE_NAME="linux"
PACKAGE_VERNAME="linux-2.6.24.4"

# NOTE: This file does not exist!
PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully pushd "$SGN_BUILD_DIR"
if [ -d "$PACKAGE_DIR" ]; then
    sgn_carefully sgn_byuser rm -rf "linux-2.6.24"
    sgn_carefully sgn_byuser rm -rf "$PACKAGE_DIR"
fi
sgn_carefully popd

sgn_carefully sgn_byuser mkdir "$SGN_BUILD_DIR/$PACKAGE_DIR"
sgn_carefully pushd "$SGN_BUILD_DIR/$PACKAGE_DIR"

sgn_carefully sgn_byuser tar xjf "$SGN_SRC_DIR/$PACKAGE_NAME/linux-2.6.24.tar.bz2"
sgn_carefully sgn_byuser cp "$SGN_SRC_DIR/$PACKAGE_NAME/patch-2.6.24.4.bz2" ./
sgn_carefully sgn_byuser bunzip2 "patch-2.6.24.4.bz2"
sgn_carefully sgn_byuser mv "linux-2.6.24" "linux-2.6.24.4"
sgn_carefully pushd "linux-2.6.24.4"

sgn_carefully sgn_byuser patch -p1 -i "../patch-2.6.24.4"
sgn_carefully sgn_byuser cp "$SGN_SRC_DIR/$PACKAGE_NAME/config" "./.config"
sgn_carefully sgn_byuser make $SGN_MAKEFLAGS

sgn_carefully sgn_install_begin
sgn_carefully make modules_install INSTALL_MOD_PATH="$SGN_PREFIX"
sgn_carefully mkdir -p "$SGN_PREFIX/boot"
sgn_carefully cp "arch/i386/boot/bzImage" "$SGN_PREFIX/boot/image-2.6.24.4"
sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_carefully popd
sgn_carefully popd

sgn_carefully sgn_cleanup
sgn_finstat

