PACKAGE_NAME="xtrans"
PACKAGE_VERNAME="xtrans-1.2.6"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --disable-docs
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS

sgn_carefully sgn_install_begin
sgn_carefully sgn_builddir make install
# 'mv' doesn't work, probably a unionfs bug.
sgn_carefully cp "$SGN_PREFIX/share/pkgconfig/xtrans.pc" "$SGN_PREFIX/lib/pkgconfig/"
sgn_carefully rm "$SGN_PREFIX/share/pkgconfig/xtrans.pc"
rmdir "$SGN_PREFIX/share/pkgconfig"
sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_carefully sgn_cleanup
sgn_finstat

