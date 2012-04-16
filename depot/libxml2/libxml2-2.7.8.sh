PACKAGE_NAME="libxml2"
PACKAGE_VERNAME="libxml2-2.7.8"

PACKAGE_ARCHIVE="libxml2-2.7.8.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

# libxml-2.0.pc.in is broken: -lz must be added to ldflags.
sgn_carefully sgn_builddir sgn_byuser sh -c "cat libxml-2.0.pc.in | sed 's/^\(Libs:.*\)$/\1 -lz/' > libxml-2.0.pc.in.new && cp libxml-2.0.pc.in.new libxml-2.0.pc.in"

# We get segfaults in zlib with innocent xml input, probably a libxml2 bug.
sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --with-threads --without-zlib
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

