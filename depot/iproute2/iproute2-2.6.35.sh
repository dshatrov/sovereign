PACKAGE_NAME="iproute2"
PACKAGE_VERNAME="iproute2-2.6.35"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"

sgn_carefully sgn_builddir sgn_byuser sed -i '/^TARGETS/s@arpd@@g' misc/Makefile

# NOTE: sed injection vulnerability for unusual directory names.
_ESCAPED_PREFIX=`echo "$SGN_PREFIX" | sed 's/\\//\\\\\//g'`
if [ -z $_ESCAPED_PREFIX ]; then
    exit 1
fi
sgn_carefully sgn_builddir sgn_byuser sed -i "1s/\\(DESTDIR=\\).*/\\1${_ESCAPED_PREFIX}/" Makefile

sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_builddir sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

