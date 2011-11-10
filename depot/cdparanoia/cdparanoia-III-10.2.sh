PACKAGE_NAME="cdparanoia"
PACKAGE_VERNAME="cdparanoia-III-10.2"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.src.tgz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser sh -c "cat interface/Makefile.in | sed 's/-shared/-shared \$(LDFLAGS)/' > interface/Makefile.in.new"
sgn_carefully sgn_builddir sgn_byuser mv interface/Makefile.in.new interface/Makefile.in

sgn_carefully sgn_builddir sgn_byuser sh -c "cat paranoia/Makefile.in | sed 's/-shared/-shared \$(LDFLAGS)/' > paranoia/Makefile.in.new"
sgn_carefully sgn_builddir sgn_byuser mv paranoia/Makefile.in.new paranoia/Makefile.in

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --enable-shared --disable-static
sgn_carefully sgn_builddir sgn_byuser make # DO NOT USE -j > 1
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

