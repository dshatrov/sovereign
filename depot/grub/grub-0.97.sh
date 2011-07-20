PACKAGE_NAME="grub"
PACKAGE_VERNAME="grub-0.97"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser patch -p1 -i "$SGN_SRC_DIR/$PACKAGE_NAME/${PACKAGE_VERNAME}_patches/grub-0.97-disk_geometry-1.patch"
sgn_carefully sgn_builddir sgn_byuser patch -p1 -i "$SGN_SRC_DIR/$PACKAGE_NAME/${PACKAGE_VERNAME}_patches/grub-0.97-256byte_inode-1.patch"
sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

