PACKAGE_NAME="Mesa"
PACKAGE_VERNAME="Mesa-7.0.3"

PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully pushd "$SGN_BUILD_DIR"
sgn_carefully sgn_byuser rm -rf "$PACKAGE_DIR"
sgn_carefully sgn_byuser tar xjf "$SGN_SRC_DIR/mesa/MesaLib-7.0.3.tar.bz2"
sgn_carefully sgn_byuser tar xjf "$SGN_SRC_DIR/mesa/MesaGLUT-7.0.3.tar.bz2"
sgn_carefully popd

SGN_PREFIX_ESCAPED=`echo "$SGN_PREFIX" | sed 's/\\//\\\\\//g'`
echo "HOME: $SGN_PREFIX_ESCAPED"
sgn_carefully sgn_builddir sgn_byuser sed -i "s/^INSTALL_DIR *=.*/INSTALL_DIR = \"$SGN_PREFIX_ESCAPED\"/" configs/default
sgn_carefully sgn_builddir sgn_byuser sed -i "s/^DRI_DRIVER_INSTALL_DIR *=.*/DRI_DRIVER_INSTALL_DIR = \"$SGN_PREFIX_ESCAPED\\/X11R6\\/lib\\/modules\\/dri\"/" configs/default

sgn_carefully sgn_builddir sgn_byuser make -j 2 linux-dri

sgn_carefully sgn_install_begin
sgn_carefully sgn_builddir make install
# DRI modules eat a lot of space (like 200Mb). Stripping shrinks them into
# merely sustainable 35Mb.
sgn_carefully pushd "$SGN_PREFIX/X11R6/lib/modules/dri"
sgn_carefully strip -s *
sgn_carefully popd

sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_carefully sgn_cleanup
sgn_finstat

