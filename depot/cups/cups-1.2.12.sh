echo "ABORTED: cups depot file is known to pollute /etc. The use of this depot file is strongly discouraged."
exit 1

PACKAGE_NAME="cups"
PACKAGE_VERNAME="cups-1.2.12"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}-source.tar.bz2"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_untar_bz2

sgn_carefully sgn_builddir sgn_byuser_script "patch -p1 < \"$SGN_SRC_DIR/${PACKAGE_NAME}/${PACKAGE_VERNAME}_patches/cups-1.2.12_clean-etc_patch\""
sgn_carefully sgn_builddir sgn_byuser_script "./configure --prefix=\"$SGN_PREFIX\" --enable-static --disable-dbus --enable-shared --disable-slp --disable-gssapi --disable-ldap --disable-ssl --disable-cdsassl --disable-gnutls --disable-openssl --disable-pam --disable-dnssd --disable-launchd --disable-browsing --disable-default-shared --disable-pdftops"
sgn_carefully sgn_builddir sgn_byuser make $SGN_MAKEFLAGS

sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

