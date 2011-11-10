PACKAGE_NAME="faac"
PACKAGE_VERNAME="faac-1.28"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz
sgn_carefully sgn_builddir sgn_byuser_script "cd include && cat faac.h | sed 's/^#ifndef HAVE_INT32_T$/#if 0/' > faac.h.new && cp faac.h.new faac.h"

sgn_carefully sgn_builddir sgn_byuser_script "patch -p1 < \"$SGN_SRC_DIR/${PACKAGE_NAME}/faac-1.28-glibc_fixes-1.patch\""
sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX"
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

