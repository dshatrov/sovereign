PACKAGE_NAME="dirac"
PACKAGE_VERNAME="dirac-1.0.2"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser sh -c "cat configure | sed 's/-pedantic//' > configure.new"

sgn_carefully sgn_builddir sgn_byuser_script "patch libdirac_encoder/quant_chooser.cpp < \"$SGN_HOME/depot/$PACKAGE_NAME/${PACKAGE_VERNAME}_stl.patch\""

sgn_carefully sgn_builddir sgn_byuser mv configure.new configure
sgn_carefully sgn_builddir sgn_byuser chmod a+x configure

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

