PACKAGE_NAME="linux"
PACKAGE_VERSION="2.6.24.4"
PACKAGE_VERNAME="linux-${PACKAGE_VERSION}"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_byuser mkdir "$SGN_BUILD_DIR/$PACKAGE_DIR"
sgn_carefully pushd "$SGN_BUILD_DIR/$PACKAGE_DIR"

sgn_carefully sgn_byuser tar xjf "$SGN_SRC_DIR/$PACKAGE_NAME/linux-2.6.24.tar.bz2"
sgn_carefully sgn_byuser cp "$SGN_SRC_DIR/$PACKAGE_NAME/patch-2.6.24.4.bz2" ./
sgn_carefully sgn_byuser bunzip2 "patch-2.6.24.4.bz2"
sgn_carefully sgn_byuser mv "linux-2.6.24" "linux-2.6.24.4"
sgn_carefully pushd "linux-2.6.24.4"

sgn_carefully sgn_byuser patch -p1 -i "../patch-2.6.24.4"

sgn_carefully sgn_byuser make mrproper
sgn_carefully sgn_byuser make headers_check
sgn_carefully sgn_byuser_script "make INSTALL_HDR_PATH=dest headers_install"

sgn_carefully sgn_install_begin
sgn_carefully mkdir -p "$SGN_PREFIX/include"
sgn_carefully cp -a dest/include/* "$SGN_PREFIX/include"
sgn_carefully sgn_prepare_package "linux-headers-${PACKAGE_VERSION}"
sgn_carefully sgn_install_end

sgn_carefully popd
sgn_carefully popd

sgn_carefully sgn_cleanup
sgn_finstat "linux-headers-${PACKAGE_VERSION}"

