PACKAGE_NAME="zlib"
PACKAGE_VERNAME="zlib-1.2.5"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

# zlib's makefile can not handle glibc with a different prefix out of the box.
sgn_carefully sgn_builddir sgn_byuser sh -c "CFLAGS=\"-mstackrealign -fPIC -O3\" ./configure --prefix=\"$SGN_PREFIX\" --shared"
sgn_carefully sgn_builddir sgn_byuser sh -c "cat Makefile | sed 's/^all:.*/all: \$(STATICLIB) \$(SHAREDLBIV)/' > Makefile.new"
sgn_carefully sgn_builddir sgn_byuser mv Makefile.new Makefile
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS

sgn_install_begin
sgn_carefully sgn_builddir make install
sgn_install_end_nocleanup

sgn_carefully sgn_builddir sgn_byuser make clean
sgn_carefully sgn_builddir sgn_byuser sh -c "CFLAGS=\"-mstackrealign -fPIC -O3\" ./configure --prefix=\"$SGN_PREFIX\""
sgn_carefully sgn_builddir sgn_byuser sh -c "cat Makefile | sed 's/^all:.*/all: \$(STATICLIB) \$(SHAREDLBIV)/' > Makefile.new"
sgn_carefully sgn_builddir sgn_byuser mv Makefile.new Makefile
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS

sgn_install_begin_nocleanup
sgn_carefully sgn_builddir make install
sgn_carefully chmod 644 "$SGN_INSTALL/lib/libz.a"

sgn_carefully sgn_prepare_package
sgn_install_end

sgn_carefully sgn_cleanup
sgn_finstat

