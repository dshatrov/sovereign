PACKAGE_NAME="gst-plugins-base"
PACKAGE_VERNAME="gst-plugins-base_11-11-10"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --disable-x --disable-xvideo --disable-xshm --disable-gnome_vfs --disable-libvisual --disable-pango --disable-examples
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

