PACKAGE_NAME="bash"
PACKAGE_VERNAME="bash-3.2"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="$PACKAGE_VERNAME"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser patch -p1 -i "$SGN_SRC_DIR/$PACKAGE_NAME/${PACKAGE_VERNAME}_patches/bash-3.2-fixes-7.patch"
sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --without-bash-malloc
sgn_carefully sgn_builddir sgn_byuser make

sgn_carefully sgn_install_begin
sgn_carefully sgn_builddir make install
if [ ! -e "$SGN_PREFIX/bin/sh" ]; then
    sgn_carefully ln -s "bash" "$SGN_PREFIX/bin/sh"
fi
sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_carefully sgn_cleanup
sgn_finstat

