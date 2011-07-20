PACKAGE_NAME="udev"
PACKAGE_VERNAME="udev-165"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.gz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz
sgn_carefully sgn_builddir sgn_byuser tar xjf "$SGN_SRC_DIR/$PACKAGE_NAME/udev-config-20100128.tar.bz2"

#sgn_carefully sgn_builddir sgn_byuser make EXTRAS="`echo extras/*/`" -j 2

sgn_carefully sgn_builddir sgn_byuser ./configure --prefix="$SGN_PREFIX" --disable-extras --disable-introspection
sgn_carefully sgn_builddir sgn_byuser make

sgn_carefully sgn_install_begin
sgn_carefully sgn_builddir make install
#sgn_carefully sgn_builddir make DESTDIR="$SGN_PREFIX/" EXTRAS="`echo extras/*/`" install

#sgn_carefully mkdir -p "$SGN_PREFIX/etc/udev/rules.d"
#sgn_carefully sgn_builddir_script "cp etc/udev/rules.d/[0-9]* \"$SGN_PREFIX/etc/udev/rules.d\""
sgn_carefully sgn_builddir make -C udev-config-20100128 install

sgn_carefully install -dv "$SGN_PREFIX"/lib/{firmware,udev/devices/{pts,shm}}
#sgn_carefully mknod -m0666 "$SGN_PREFIX"/lib/udev/devices/null c 1 3

if [ ! -e "$SGN_PREFIX/lib/udev/devices/null" ]; then
	mknod -m0666 "$SGN_PREFIX"/lib/udev/devices/null c 1 3
fi

if [ ! -e "$SGN_PREFIX/lib/udev/devices/fd" ]; then
	sgn_carefully ln -sv /proc/self/fd "$SGN_PREFIX/lib/udev/devices/fd"
fi

if [ ! -e "$SGN_PREFIX/lib/udev/devices/stdin" ]; then
	sgn_carefully ln -sv /proc/self/fd/0 "$SGN_PREFIX/lib/udev/devices/stdin"
fi

if [ ! -e "$SGN_PREFIX/lib/udev/devices/stdout" ]; then
	sgn_carefully ln -sv /proc/self/fd/1 "$SGN_PREFIX/lib/udev/devices/stdout"
fi

if [ ! -e "$SGN_PREFIX/lib/udev/devices/stderr" ]; then
	sgn_carefully ln -sv /proc/self/fd/2 "$SGN_PREFIX/lib/udev/devices/stderr"
fi

if [ ! -e "$SGN_PREFIX/lib/udev/devices/core" ]; then
	sgn_carefully ln -sv /proc/kcore "$SGN_PREFIX/lib/udev/devices/core"
fi

sgn_carefully sgn_prepare_package
sgn_carefully sgn_install_end

sgn_carefully sgn_cleanup
sgn_finstat

