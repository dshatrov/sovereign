PACKAGE_NAME="glib"
PACKAGE_VERNAME="glib-2.32.0"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.xz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_

sgn_carefully sgn_builddir sgn_byuser patch -p1 -i "$SGN_HOME/depot/glib/glib-2.32.0_nodepr.patch"

if test "x$SGN_PLATFORM_WIN32" = "xyes"; then
  # For pkg-config on mingw 32bit.
  sgn_carefully sgn_builddir sgn_byuser patch -p1 -i "$SGN_HOME/depot/glib/glib-2.32.0_noprivate.patch"

  sgn_carefully sgn_builddir sgn_byuser patch -p1 -i "$SGN_HOME/depot/glib/glib-2.32.0_notests-nopython.patch"
  sgn_carefully sgn_builddir sgn_byuser sh -c "CFLAGS=\"$CFLAGS -march=i686\" LIBFFI_CFLAGS=\"-I/opt/moment/lib/libffi-3.0.10/include\" LIBFFI_LIBS=\"-L/opt/moment/lib -lffi\" ./configure --prefix=/opt/moment --disable-gtk-doc --disable-gtk-doc-html --disable-gtk-doc-pdf"
else
  sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --disable-selinux --disable-gtk-doc --disable-gtk-doc-html --disable-gtk-doc-pdf
fi

sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

