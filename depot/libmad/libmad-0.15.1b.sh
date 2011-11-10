PACKAGE_NAME="libmad"
PACKAGE_VERNAME="libmad-0.15.1b"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

# libmad uses -fforce-mem gcc options, which is not supported in newer gcc versions.
sgn_carefully sgn_builddir sgn_byuser sh -c "cat configure | sed 's/.*-fforce-mem.*//' > configure.new"
sgn_carefully sgn_builddir sgn_byuser mv configure.new configure
sgn_carefully sgn_builddir sgn_byuser chmod a+x configure

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

