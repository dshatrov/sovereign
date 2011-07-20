#PACKAGE_NAME="gcc+gm2"
PACKAGE_VERNAME="gcc-4.1.2+gm2-cvs_07-12-20_10-57"

PACKAGE_ARCHIVE="gcc-4.1.2.tar.bz2"
PACKAGE_DIR="gcc-4.1.2"

sgn_carefully cd "$SGN_BUILD_DIR"
sgn_carefully sgn_byuser rm -rf "$PACKAGE_DIR"
sgn_carefully sgn_byuser rm -rf "gcc-build"
sgn_carefully sgn_byuser tar xjf "$SGN_SRC_DIR/gcc/$PACKAGE_ARCHIVE"
sgn_carefully sgn_byuser mkdir "gcc-build"

sgn_carefully cd "$PACKAGE_DIR/gcc"
sgn_carefully sgn_byuser tar xzf "$SGN_SRC_DIR/gcc/gm2-cvs_07-12-20_10-57.tar.gz"
cd ".."

sgn_carefully sgn_byuser_script "patch -p1 < \"$SGN_SRC_DIR/gcc/patch_gm2_gcc-4.1.2_makeversion\""
sgn_carefully sgn_byuser_script "patch -p1 < \"$SGN_SRC_DIR/gcc/patch_gm2_gcc-4.1.2_createUlmSys\""
sgn_carefully sgn_byuser_script "patch -p1 < \"$SGN_SRC_DIR/gcc/patch_gm2_gcc-4.1.2_Make-lang.in\""

sgn_carefully sgn_byuser_script "cp -v gcc/Makefile.in{,.orig}"
sgn_carefully sgn_byuser_script "sed 's@\./fixinc\.sh@-c true@' gcc/Makefile.in.orig > gcc/Makefile.in"

sgn_carefully sgn_byuser_script "cp -v gcc/Makefile.in{,.tmp}"
sgn_carefully sgn_byuser_script "sed 's/^XCFLAGS =\$/& -fomit-frame-pointer/' gcc/Makefile.in.tmp > gcc/Makefile.in"

sgn_carefully sgn_byuser_script "
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

cd ".."

sgn_carefully mkdir -p "$SGN_PREFIX/opt/gm2"

sgn_carefully cd "gcc-build"
sgn_carefully sgn_byuser_script "../${PACKAGE_DIR}/configure --prefix=\"$SGN_PREFIX/opt/gm2\" --with-local-prefix=\"$SGN_PREFIX\" --enable-languages=c,c++,gm2 --enable-shared --enable-clocale=gnu --enable-threads=posix --enable-__cxa_atexit --disable-libstdcxx-pch --disable-bootstrap"
sgn_carefully sgn_byuser make

sgn_carefully sgn_install_begin
sgn_carefully make install
sgn_carefully ln -s "../bin/cpp" "$SGN_PREFIX/opt/gm2/lib"
sgn_carefully ln -s gcc "$SGN_PREFIX/opt/gm2/bin/cc"
sgn_carefully cd "$SGN_INSTALL"
sgn_carefully tar czf "$SGN_SGN_DIR/${PACKAGE_VERNAME}${SGN_PACKAGE_SUFFIX}.sgn" *
sgn_carefully sgn_install_end

sgn_carefully cd "$SGN_BUILD_DIR"
sgn_carefully sgn_byuser rm -rf "$PACKAGE_DIR"
sgn_carefully sgn_byuser rm -rf "gcc-build"

sgn_finstat

