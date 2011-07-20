PACKAGE_NAME="linux-headers"
PACKAGE_VERSION="2.6.36.2"
PACKAGE_VERNAME="linux-${PACKAGE_VERSION}"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_byuser mkdir -p "$SGN_BUILD_DIR/$PACKAGE_DIR"
sgn_carefully pushd "$SGN_BUILD_DIR/$PACKAGE_DIR"

sgn_carefully sgn_byuser tar xzf "$SGN_SRC_DIR/$PACKAGE_NAME/linux-2.6.36.2.tar.gz"
sgn_carefully pushd "linux-2.6.36.2"

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

