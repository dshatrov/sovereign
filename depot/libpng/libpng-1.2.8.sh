PACKAGE_NAME="libpng"
PACKAGE_VERNAME="libpng-1.2.8"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2

# TODO String escapement for sed
sgn_carefully sgn_builddir sgn_byuser_script "cat scripts/makefile.linux | sed \"s|^prefix=.*\$|prefix=${SGN_PREFIX}|\" > Makefile"
sgn_carefully sgn_builddir sgn_byuser make -j 2
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

