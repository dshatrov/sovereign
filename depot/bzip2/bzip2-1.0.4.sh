PACKAGE_NAME="bzip2"
PACKAGE_VERNAME="bzip2-1.0.4"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser make -f Makefile-libbz2_so
sgn_carefully sgn_builddir sgn_byuser make clean
sgn_carefully sgn_builddir sgn_byuser make

sgn_carefully sgn_install_begin
sgn_carefully sgn_builddir make PREFIX=\"$SGN_PREFIX\" install
sgn_carefully rm -f "$SGN_PREFIX/bin/bunzip2"
sgn_carefully rm -f "$SGN_PREFIX/bin/bzcat"
sgn_carefully ln -s bzip2 "$SGN_PREFIX/bin/bunzip2"
sgn_carefully ln -s bzip2 "$SGN_PREFIX/bin/bzcat"
sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_carefully sgn_cleanup
sgn_finstat

