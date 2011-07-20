PACKAGE_NAME="fontconfig"
PACKAGE_VERNAME="fontconfig-2.5.0"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --disable-docs
sgn_carefully sgn_builddir sgn_byuser make -j 2

# NOTE: Some caching of /usr/share/fonts/* happens here. No good.
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

