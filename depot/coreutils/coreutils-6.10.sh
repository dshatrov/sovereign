PACKAGE_NAME="coreutils"
PACKAGE_VERNAME="coreutils-6.10"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser patch -p1 -i "$SGN_SRC_DIR/$PACKAGE_NAME/${PACKAGE_VERNAME}_patches/coreutils-6.10-i18n-1.patch"
sgn_carefully sgn_builddir sgn_byuser patch -p1 -i "$SGN_SRC_DIR/$PACKAGE_NAME/${PACKAGE_VERNAME}_patches/coreutils-6.10-uname-1.patch"
sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --enable-install-program=hostname
sgn_carefully sgn_builddir sgn_byuser make

# NOTE: installation of 'su' requires root privileges.
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

