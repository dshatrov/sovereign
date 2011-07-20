PACKAGE_NAME="linux"
PACKAGE_VERSION="2.6.23.8"
PACKAGE_VERNAME="linux-${PACKAGE_VERSION}"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2

sgn_carefully cd "$SGN_BUILD_DIR/$PACKAGE_DIR"
sgn_carefully sgn_byuser make mrproper
# FIXME env? (debugging output?)
env
sgn_carefully sgn_byuser make headers_check
sgn_carefully sgn_byuser_script "make INSTALL_HDR_PATH=dest headers_install"

sgn_carefully sgn_install_begin
sgn_carefully mkdir -p "$SGN_PREFIX/include"
sgn_carefully cp -a dest/include/* "$SGN_PREFIX/include"
sgn_carefully sgn_prepare_package "linux-header-${PACKAGE_VERSION}"
sgn_carefully sgn_install_end

sgn_carefully sgn_cleanup
sgn_finstat "linux-headers-${PACKAGE_VERSION}"

