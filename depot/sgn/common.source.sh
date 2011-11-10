sgn_carefully ()
{
    echo "Performing $*"
    if ! "$@"; then
	echo "$* failed"
	exit 1
    fi
}

sgn_carefully_script ()
{
    local SCRIPT="$1"

    echo "Executing script: \"$SCRIPT\""
    /bin/bash -c "$SCRIPT"
    if [ $? != 0 ]; then
	echo "Script \"$SCRIPT\" failed"
	exit 1
    fi
}

sgn_escape_command ()
{
    local SED_ADJ='s/\\/\\\\/g'
    local SED_SCRIPT="$SED_ADJ"

    SED_ADJ='s/\$/\\$/g'
    SED_SCRIPT="$SED_SCRIPT;$SED_ADJ"

    SED_ADJ='s/"/\\"/g'
    SED_SCRIPT="$SED_SCRIPT;$SED_ADJ"

    SED_ADJ='s/`/\\`/g'
    SED_SCRIPT="$SED_SCRIPT;$SED_ADJ"

    for ARG in "$@"; do
	echo -n "\""
	echo -n "$ARG" | sed "$SED_SCRIPT"
	echo -n "\" "
    done
}

sgn_byuser ()
{
    if [ -z "$*" ]; then
	exit 1
    fi

# TEST LINE
#    echo "sgn_byuser: `sgn_escape_command "$@"`"

    if [ `id -un` = "$SGN_USER" ]; then
	"$@"
    else
	su "$SGN_USER" -m -c "export PATH=$PATH; `sgn_escape_command "$@"`"
    fi
}

sgn_byuser_script ()
{
    local SCRIPT="$1"

    if [ -z "$SCRIPT" ]; then
	exit 1
    fi

    su "$SGN_USER" -m -c "export PATH=$PATH; $1"
}

sgn_cleanup_dir ()
{
    local DIR="$1"
    if [ -z "$DIR" ]; then
	echo "sgn_cleanup_dir: directory not specified"
	exit 1
    fi

    # NOTE: This segfaults with find from findutils-4.2.(?) (almost-empty environment matters).
    sgn_carefully find "$DIR" -xdev -mindepth 1 -maxdepth 1 -execdir rm --preserve-root -rf {} +
}

sgn_check_variable ()
{
    local _VAR_NAME="$1";
    if [ -z "$_VAR_NAME" ]; then
	echo "sgn_check_variable: variable name not specified"
	exit 1
    fi

    local _VALUE=`eval "echo \\$$1"`
    if [ -z "$_VALUE" ]; then
	echo "$_VAR_NAME is not set"
	exit 1
    fi
}

sgn_ensure_directory_superuser ()
{
    local _VAR_NAME="$1"
    sgn_check_variable "$_VAR_NAME"

    # Overlaps with the previous check
    local _DIR_NAME=`eval "echo \\$$_VAR_NAME"`
    if [ -z "$_DIR_NAME" ]; then
	echo "sgn_ensure_directory_superuser: directory not specified"
	exit 1
    fi

    if [ ! -d "$_DIR_NAME" ]; then
	sgn_carefully mkdir -p "$_DIR_NAME"
    fi
}

sgn_ensure_directory ()
{
    local _VAR_NAME="$1"
    sgn_check_variable "$_VAR_NAME"

    # Overlaps with the previous check
    local _DIR_NAME=`eval "echo \\$$_VAR_NAME"`
    if [ -z "$_DIR_NAME" ]; then
	echo "sgn_ensure_directory: directory not specified"
	exit 1
    fi

    if [ ! -d "$_DIR_NAME" ]; then
	sgn_carefully sgn_byuser mkdir -p "$_DIR_NAME"
    fi
}

# *** SCRIPT BEGINS HERE ***

sgn_check_variable "SGN_HOME"

. "$SGN_HOME/sgn_config"
if [ $? != 0 ]; then
    echo "sgn/common.source.sh: failed to include \"$SGN_HOME/sgn_config\""
    exit 1
fi

sgn_check_variable "SGN_PREFIX"
sgn_check_variable "SGN_USER"

# Alternate prefix is used to build livecd packages which don't go into an initrd.
SGN_ORIGINAL_PREFIX="$SGN_PREFIX"
if [ ! -z "$SGN_ALTERNATE_PREFIX" ]; then
    SGN_PREFIX="$SGN_ALTERNATE_PREFIX"
fi

# Start of bashrc

if [ ! -z "$BASH" ]; then
    set +h
fi

umask 022
export LC_ALL=POSIX
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
if [ ! -z "$SGN_EXTRA_PATH" ]; then
    export PATH="$SGN_EXTRA_PATH:$PATH"
fi
export PATH="$SGN_ORIGINAL_PREFIX/sbin:$SGN_ORIGINAL_PREFIX/bin:$PATH"
if [ ! -z "$SGN_ALTERNATE_PREFIX" ]; then
    export PATH="$SGN_ALTERNATE_PREFIX/sbin:$SGN_ALTERNATE_PREFIX/bin:$PATH"
fi
echo "PATH: $PATH"

# (End of bashrc)

sgn_ensure_directory_superuser "SGN_PREFIX"
sgn_ensure_directory_superuser "SGN_LIVECD_PREFIX"
sgn_ensure_directory "SGN_SRC_DIR"
sgn_ensure_directory "SGN_BUILD_DIR"
sgn_ensure_directory "SGN_SGN_DIR"
sgn_ensure_directory "SGN_LIVECD_DIR"

SGN_SYSTEM="$SGN_BUILD_DIR/sgn/system"
SGN_INSTALL="$SGN_BUILD_DIR/sgn/install"
SGN_EMPTY="$SGN_BUILD_DIR/sgn/empty"

sgn_ensure_directory "SGN_SYSTEM"
sgn_ensure_directory "SGN_INSTALL"
sgn_ensure_directory "SGN_EMPTY"

sgn_cleanup_dir "$SGN_EMPTY"

# 32bit
#SGN_COMMON_CFLAGS="-Wl,--dynamic-linker=$SGN_PREFIX/lib/ld-linux.so.2 -Wl,-L$SGN_PREFIX/lib"
#SGN_LDFLAGS="-Wl,--dynamic-linker=$SGN_PREFIX/lib/ld-linux.so.2 -Wl,-L$SGN_PREFIX/lib"

# 64bit
#SGN_COMMON_CFLAGS="-Wl,--dynamic-linker=$SGN_PREFIX/lib/ld-linux-x86-64.so.2 -Wl,-L$SGN_PREFIX/lib -Wl,-rpath='$ORIGIN/../lib'"
#SGN_LDFLAGS="-Wl,-L$SGN_PREFIX/lib -Wl,-rpath=$SGN_PREFIX/lib"
#SGN_LDFLAGS="-Wl,-rpath=$SGN_PREFIX/lib"

SGN_LDFLAGS="-Wl,--dynamic-linker=$SGN_PREFIX/lib/ld-linux-x86-64.so.2 -Wl,-L$SGN_PREFIX/lib -Wl,-rpath=$SGN_PREFIX/lib"
#SGN_LDFLAGS="-Wl,-L$SGN_PREFIX/lib -Wl,-rpath=$SGN_PREFIX/lib"

export CFLAGS="$CFLAGS -I$SGN_PREFIX/include $SGN_COMMON_CFLAGS -O2 -g"
export CXXFLAGS="$CXXFLAGS -I$SGN_PREFIX/include $SGN_COMMON_CFLAGS -O2 -g"
export LDFLAGS="$LDFLAGS -L$SGN_PREFIX/lib $SGN_LDFLAGS"

# *** (SCRIPT ENDS HERE) ***

# mount and umount appear in $SGN_PREFIX during installation of util-linux-ng
# Note that if mount appears to a library from $SGN_PREFIX (like
# /opt/sgn/libc.so.6), then it will fail because the filesystem to unmount is
# busy. That's why we enforce library search paths.
#
# Note: Actually, I haven't yet figured out why umount fails after doing
# install of glibc on newer systems. One has to "help" with unmounting by hand
# currently....
UMOUNT="env LD_RUN_PATH=/lib:/usr/lib LD_LIBRARY_PATH=/lib:/usr/lib /bin/umount"
MOUNT="env LD_RUN_PATH=/lib:/usr/lib LD_LIBRARY_PATH=/lib:/usr/lib /bin/mount"


# TODO Sleep here?
sgn_umount_all () {
# 'fusermount 'somewhy fails with "device is busy". Works fine with 'umount'.
#    while fusermount -u "$SGN_SYSTEM" > /dev/null 2>&1; do true; done
    while $UMOUNT "$SGN_PREFIX"        > /dev/null 2>&1; do true; done

    while $UMOUNT "$SGN_EMPTY"         > /dev/null 2>&1; do true; done
    while $UMOUNT "$SGN_PREFIX"        > /dev/null 2>&1; do true; done
}

sgn_setenv () {
# This makes everything segfault with incompatible glibc.
#    if [ -z "$LD_LIBRARY_PATH" ]; then
#	export LD_LIBRARY_PATH="$SGN_ORIGINAL_PREFIX/lib"
#    else
#	export LD_LIBRARY_PATH="$SGN_ORIGINAL_PREFIX/lib:$LD_LIBRARY_PATH"
#    fi

    if [ -z "$PKG_CONFIG_PATH" ]; then
	export PKG_CONFIG_PATH="$SGN_ORIGINAL_PREFIX/lib/pkgconfig"
    else
	export PKG_CONFIG_PATH="$SGN_ORIGINAL_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
    fi

    if [ ! -z "$SGN_ALTERNATE_PREFIX" ]; then
#	if [ -z "$LD_LIBRARY_PATH" ]; then
#	    export LD_LIBRARY_PATH="$SGN_ALTERNATE_PREFIX/lib"
#	else
#	    export LD_LIBRARY_PATH="$SGN_ALTERNATE_PREFIX/lib:$LD_LIBRARY_PATH"
#	fi

	if [ -z "$PKG_CONFIG_PATH" ]; then
	    export PKG_CONFIG_PATH="$SGN_ALTERNATE_PREFIX/lib/pkgconfig"
	else
	    export PKG_CONFIG_PATH="$SGN_ALTERNATE_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
	fi
    fi

    sgn_umount_all
}

sgn_builddir ()
{
    sgn_carefully pushd "$SGN_BUILD_DIR/$PACKAGE_DIR"
    if ! "$@"; then
	exit 1
    fi
    sgn_carefully popd
}

sgn_builddir_script ()
{
    local SCRIPT="$1"

    sgn_carefully pushd "$SGN_BUILD_DIR/$PACKAGE_DIR"
    echo "Executing script: \"$SCRIPT\""
    /bin/bash -c "$SCRIPT"
    if [ $? != 0 ]; then
	echo "Script \"$SCRIPT\" failed"
	exit 1
    fi
    sgn_carefully popd
}

# Unarchiving functions

sgn_untar ()
{
    local UNPACK_COMMAND="$1"
    local PACKAGE_DIR="$2"
    local PACKAGE_ARCHIVE="$3"

    sgn_carefully pushd "$SGN_BUILD_DIR"
    if [ -d "$PACKAGE_DIR" ]; then
	sgn_carefully sgn_byuser rm -rf "$PACKAGE_DIR"
    fi
    sgn_carefully sgn_byuser $UNPACK_COMMAND "$SGN_SRC_DIR/$PACKAGE_ARCHIVE"
    sgn_carefully popd
}

sgn_unarchive_check_variables ()
{
    if [ -z "$PACKAGE_DIR" ]; then
	echo "sgn_unarchive_check_variables: \$PACKAGE_DIR is not set"
	exit 1
    fi

    if [ -z "$PACKAGE_NAME" ]; then
	echo "sgn_unarchive_check_variables: \$PACKAGE_NAME is not set"
	exit 1
    fi

    if [ -z "$PACKAGE_ARCHIVE" ]; then
	echo "sgn_unarchive_check_variables: \$PACKAGE_ARCHIVE is not set"
	exit 1
    fi
}

sgn_untar_gz ()
{
    local _ARCHIVE="$1"

    if [ -z "$_ARCHIVE" ]; then
	local _ARCHIVE="$PACKAGE_NAME/$PACKAGE_ARCHIVE"
    fi

    sgn_carefully sgn_unarchive_check_variables
    sgn_carefully sgn_untar "tar xzf" "$PACKAGE_DIR" "$_ARCHIVE"
}

sgn_untar_bz2 ()
{
    local _ARCHIVE="$1"

    if [ -z "$_ARCHIVE" ]; then
	local _ARCHIVE="$PACKAGE_NAME/$PACKAGE_ARCHIVE"
    fi

    sgn_carefully sgn_unarchive_check_variables
    sgn_carefully sgn_untar "tar xjf" "$PACKAGE_DIR" "$_ARCHIVE"
}

# (End of unarchiving functions)

sgn_mount_unionfs_unsafe ()
{
    echo "Running: " unionfs --hidedb /var/tmp/sgn_unionfs_hidedb	\
	    "$SGN_INSTALL=rw:$SGN_SYSTEM"		\
	    "$SGN_PREFIX"				\
	    -o allow_other

    LD_LIBRARY_PATH=""					\
    unionfs --hidedb /var/tmp/sgn_unionfs_hidedb	\
	    "$SGN_INSTALL=rw:$SGN_SYSTEM"		\
	    "$SGN_PREFIX"				\
	    -o allow_other

    # Note: don't put any commands here! This functions must return the exit
    # status of the unionfs command above.
}

sgn_install_cleanup ()
{
    sgn_carefully pushd "$SGN_INSTALL"
    sgn_carefully sgn_cleanup_dir "$SGN_INSTALL"
    sgn_carefully popd
}

sgn_install_begin_nocleanup ()
{
    sgn_umount_all

    sgn_carefully $MOUNT --bind "$SGN_PREFIX" "$SGN_SYSTEM"
    sgn_carefully $MOUNT --bind "$SGN_EMPTY" "$SGN_PREFIX"

    sgn_mount_unionfs_unsafe
    if [ $? != 0 ]; then
	sgn_carefully modprobe fuse
	sgn_carefully sgn_mount_unionfs_unsafe
    fi
}

sgn_install_begin ()
{
    sgn_install_cleanup
    sgn_install_begin_nocleanup
}

sgn_install_end_nocleanup ()
{
    echo "sgn/install_end.sh: sleeping 3 seconds..."
    sleep 3

    # Note: fusermount is unnecessary now.
    if ! which fusermount > /dev/null; then
	echo "fusermount not found"
	exit 1
    fi

# 'fusermount 'somewhy fails with "device is busy". Works fine with 'umount'.
#    sgn_carefully fusermount -u "$SGN_PREFIX"
#
# Note: It didn't "work fine" anymore with make_install_livecd. That's why
# we're now looping on this and printing lsof for debugging.
    while true; do 
	echo "which ldd"
	which ldd
	echo "ldd /bin/umount"
	ldd /bin/umount

	$UMOUNT "$SGN_PREFIX"
	if [ $? = 0 ]; then
	    break;
	fi

	echo "Failed to unmount $SGN_PREFIX, retrying..."
	echo "lsof -n \"$SGN_PREFIX\""
	lsof -n "$SGN_PREFIX"
	echo "/usr/bin/ldd /bin/umount"
	/usr/bin/ldd /bin/umount
	sleep 1
    done

    echo "sgn/install_end.sh: sleeping 3 more seconds..."
    sleep 3;

# We do not care about careful unmounting here, because we're calling
# sgn_umount_all below anyway.
#    sgn_carefully $UMOUNT "$SGN_PREFIX"
    $UMOUNT "$SGN_PREFIX"
    sgn_carefully $UMOUNT "$SGN_SYSTEM"

    # Calling sgn_umount_all just to be sure that we're in the clear.
    sgn_umount_all
}

sgn_install_end ()
{
    sgn_install_end_nocleanup
    sgn_install_cleanup
}

sgn_prepare_package ()
{
    local _PKG_NAME="$1"

    if [ -z "$_PKG_NAME" ]; then
	local _PKG_NAME="$PACKAGE_VERNAME"
    fi

    sgn_carefully pushd "$SGN_INSTALL"
    sgn_carefully tar czf "$SGN_SGN_DIR/${_PKG_NAME}${SGN_PACKAGE_SUFFIX}.sgn" *
    sgn_carefully popd
}

sgn_make_install ()
{
    sgn_carefully sgn_install_begin
    sgn_carefully sgn_builddir make install
    sgn_carefully sgn_prepare_package
    sgn_carefully sgn_install_end
}

sgn_cleanup ()
{
    sgn_carefully sgn_byuser rm -rf "$SGN_BUILD_DIR/$PACKAGE_DIR"
}

sgn_finstat ()
{
    local _PKG_NAME="$1"

    if [ -z "$_PKG_NAME" ]; then
	local _PKG_NAME="$PACKAGE_VERNAME"
    fi

    echo
    echo "Okay! :)"
    du -sh "$SGN_SGN_DIR/${_PKG_NAME}${SGN_PACKAGE_SUFFIX}.sgn"
}

