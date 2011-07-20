PACKAGE_NAME="gcc"
PACKAGE_VERNAME="gcc-4.2.2"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_bz2

sgn_carefully cd "$SGN_BUILD_DIR"
sgn_carefully sgn_byuser rm -rf "gcc-build"
sgn_carefully sgn_byuser mkdir "gcc-build"

sgn_carefully sgn_builddir sgn_byuser_script "patch -p1 < \"$SGN_SRC_DIR/${PACKAGE_NAME}/${PACKAGE_VERNAME}_patches/gcc-4.2.2_dwarf2out_c_patch\""

sgn_carefully sgn_builddir sgn_byuser_script "cp -v gcc/Makefile.in{,.orig}"
sgn_carefully sgn_builddir sgn_byuser_script "sed 's@\./fixinc\.sh@-c true@' gcc/Makefile.in.orig > gcc/Makefile.in"

sgn_carefully sgn_builddir sgn_byuser_script "cp -v gcc/Makefile.in{,.tmp}"
sgn_carefully sgn_builddir sgn_byuser_script "sed 's/^XCFLAGS =\$/& -fomit-frame-pointer/' gcc/Makefile.in.tmp > gcc/Makefile.in"

sgn_carefully sgn_builddir sgn_byuser_script "
    for file in \$(find gcc/config -name linux64.h -o -name linux.h)
    do
        cp -uv \$file{,.orig}
        sed -e 's@/lib\(64\)\?\(32\)\?/ld@/$SGN_PREFIX&@g' \\
            -e 's@/usr@/$SGN_PREFIX@g' \$file.orig > \$file
        echo \"
#undef STANDARD_INCLUDE_DIR
#define STANDARD_INCLUDE_DIR 0\" >> \$file
        touch \$file.orig
    done"

sgn_carefully cd "$SGN_BUILD_DIR/gcc-build"
sgn_carefully sgn_byuser_script "../${PACKAGE_DIR}/configure --prefix=\"$SGN_PREFIX\" --with-local-prefix=\"$SGN_PREFIX\" --enable-languages=c,c++ --enable-shared --enable-clocale=gnu --enable-threads=posix --enable-__cxa_atexit --disable-libstdcxx-pch --disable-bootstrap"
sgn_carefully sgn_byuser make

sgn_carefully sgn_install_begin
sgn_carefully make install
sgn_carefully rm -f "$SGN_PREFIX/lib/cpp"
sgn_carefully rm -f "$SGN_PREFIX/bin/cc"
sgn_carefully ln -s "../bin/cpp" "$SGN_PREFIX/lib"
sgn_carefully ln -s gcc "$SGN_PREFIX/bin/cc"
sgn_carefully sgn_prepare_package "${PACKAGE_VERNAME}_pass2"
sgn_carefully sgn_install_end

sgn_carefully sgn_byuser rm -rf "$SGN_BUILD_DIR/gcc-build"

sgn_carefully sgn_cleanup
sgn_finstat "${PACKAGE_VERNAME}_pass2"

