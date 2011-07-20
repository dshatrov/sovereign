PACKAGE_NAME="sgn_test"
PACKAGE_VERNAME="sgn_test-0.1"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_install_begin
sgn_carefully touch "$SGN_PREFIX/test_file"
sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_finstat

