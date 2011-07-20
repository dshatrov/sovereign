PACKAGE_NAME="glibc"
PACKAGE_VERNAME="glibc-2.12.2"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"


sgn_carefully sgn_untar_gz

sgn_carefully cd "$SGN_BUILD_DIR"

sgn_carefully pushd "$PACKAGE_VERNAME"
sgn_carefully sgn_builddir sgn_byuser_script "patch -p1 < \"$SGN_SRC_DIR/${PACKAGE_NAME}/glibc-2.12.2-gcc_fix-1.patch\""
sgn_carefully popd

sgn_carefully sgn_byuser rm -rf "glibc-build"
sgn_carefully sgn_byuser mkdir "glibc-build"

sgn_carefully cd "glibc-build"

#sgn_carefully sgn_byuser_script "echo \"CFLAGS += -march=i486 -g -O2\" > configparms"
#sgn_carefully sgn_byuser_script "echo \"CFLAGS += -march=i486 -U_FORTIFY_SOURCE -O2 -fno-stack-protector\" > configparms"
sgn_carefully sgn_byuser_script "echo \"CFLAGS += -U_FORTIFY_SOURCE -O2 -fno-stack-protector\" > configparms"
sgn_carefully sgn_byuser_script "../glibc-2.12.2/configure --prefix=\"$SGN_PREFIX\" --disable-profile --enable-add-ons --enable-kernel=2.6.0 --without-selinux --with-headers=\"$SGN_PREFIX/include\" --with-binutils=\"$SGN_PREFIX/bin\" libc_cv_forced_unwind=yes libc_cv_c_cleanup=yes"
sgn_carefully sgn_byuser make -j 2

sgn_carefully sgn_install_begin
sgn_carefully mkdir -p "$SGN_PREFIX/etc"
sgn_carefully touch "$SGN_PREFIX/etc/ld.so.conf"
sgn_carefully make install

sgn_carefully mkdir -pv "$SGN_PREFIX/lib/locale"
sgn_carefully localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
sgn_carefully localedef -i de_DE -f ISO-8859-1 de_DE
sgn_carefully localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
sgn_carefully localedef -i de_DE -f UTF-8 de_DE.UTF-8
sgn_carefully localedef -i en_HK -f ISO-8859-1 en_HK
sgn_carefully localedef -i en_PH -f ISO-8859-1 en_PH
sgn_carefully localedef -i en_US -f ISO-8859-1 en_US
sgn_carefully localedef -i en_US -f UTF-8 en_US.UTF-8
sgn_carefully localedef -i es_MX -f ISO-8859-1 es_MX
sgn_carefully localedef -i fa_IR -f UTF-8 fa_IR
sgn_carefully localedef -i fr_FR -f ISO-8859-1 fr_FR
sgn_carefully localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
sgn_carefully localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
sgn_carefully localedef -i it_IT -f ISO-8859-1 it_IT
sgn_carefully localedef -i ja_JP -f EUC-JP ja_JP
sgn_carefully localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
sgn_carefully localedef -i zh_CN -f GB18030 zh_CN.GB18030
sgn_carefully localedef -i ru_RU -f UTF-8 ru_RU.UTF-8

sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_carefully sgn_byuser rm -rf "$SGN_BUILD_DIR/glibc-build"

sgn_cleanup
sgn_finstat

