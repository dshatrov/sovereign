PACKAGE_NAME="ncurses"
PACKAGE_VERNAME="ncurses-5.7"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --with-shared --without-debug --enable-widec
sgn_carefully sgn_builddir sgn_byuser make

sgn_carefully sgn_install_begin
sgn_carefully sgn_builddir make install
sgn_carefully chmod -v 644 "$SGN_PREFIX/lib/libncurses++w.a"

# This is for util-linux-ng-2.13.1 to build
#sgn_carefully ln -s "ncurses/term.h" "$SGN_PREFIX/include/term.h"

sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_carefully sgn_cleanup
sgn_finstat

