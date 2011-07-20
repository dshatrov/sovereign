PACKAGE_NAME="flac"
PACKAGE_VERNAME="flac-1.2.1"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --disable-thorough-tests --disable-tests
# There's an error in one of the examples ("memcpy undeclared").
sgn_carefully sgn_builddir sgn_byuser_script "cat Makefile | sed 's/SUBDIRS *=\(.*\)examples\(.*\)/SUBDIRS = \1\2/' > Makefile.new && cp Makefile.new Makefile"
sgn_carefully sgn_builddir sgn_byuser make -j 2
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

