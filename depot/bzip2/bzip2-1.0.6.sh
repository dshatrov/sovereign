PACKAGE_NAME="bzip2"
PACKAGE_VERNAME="bzip2-1.0.6"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

echo "CFLAGS: $CFLAGS"

#sgn_carefully sgn_builddir sgn_byuser sh -c "cat Makefile-libbz2_so | sed 's/^\(CFLAGS=.*\)$/\1 -I\/opt\/moment\/include -Wl,--dynamic-linker=\/opt\/moment\/lib\/ld-linux.so.2 -Wl,-L\/opt\/moment\/lib/' > Makefile-libbz2_so.new && cp Makefile-libbz2_so.new Makefile-libbz2_so"

sgn_carefully sgn_builddir sgn_byuser sh -c "echo \"CFLAGS=$CFLAGS\"    > Makefile-libbz2_so.new"
sgn_carefully sgn_builddir sgn_byuser sh -c "echo \"LDFLAGS=$LDFLAGS\" >> Makefile-libbz2_so.new"
sgn_carefully sgn_builddir sgn_byuser sh -c "cat Makefile-libbz2_so | sed 's/^CFLAGS[ \t]*=/CFLAGS+=/' | sed 's/^LDFLAGS[ \t]*=/LDFLAGS+=/' | sed 's/ -shared/ -shared \\\$(LDFLAGS)/' | sed 's/-o bzip2-shared/-o bzip2-shared \\\$(LDFLAGS)/' >> Makefile-libbz2_so.new"
sgn_carefully sgn_builddir sgn_byuser sh -c "mv Makefile-libbz2_so.new  Makefile-libbz2_so"

sgn_carefully sgn_builddir sgn_byuser make -f Makefile-libbz2_so
sgn_carefully sgn_builddir sgn_byuser make clean
sgn_carefully sgn_builddir sgn_byuser make

sgn_carefully sgn_install_begin
sgn_carefully sgn_builddir make PREFIX=\"$SGN_PREFIX\" install
sgn_carefully sgn_builddir cp -v bzip2-shared "$SGN_PREFIX/bin/bzip2"
sgn_carefully sgn_builddir sh -c "cp -v libbz2.so* \"$SGN_PREFIX/lib\""
sgn_carefully rm -f "$SGN_PREFIX/lib/libbz2.so"
sgn_carefully ln -sv libbz2.so.1.0 "$SGN_PREFIX/lib/libbz2.so"
sgn_carefully rm -f "$SGN_PREFIX/bin/bunzip2"
sgn_carefully rm -f "$SGN_PREFIX/bin/bzcat"
sgn_carefully rm -f "$SGN_PREFIX/bin/bunzip2" "$SGN_PREFIX/bin/bzcat"
sgn_carefully ln -s bzip2 "$SGN_PREFIX/bin/bunzip2"
sgn_carefully ln -s bzip2 "$SGN_PREFIX/bin/bzcat"
sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_carefully sgn_cleanup
sgn_finstat

