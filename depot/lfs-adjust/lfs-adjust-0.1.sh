#!/bin/sh

sgn_carefully sgn_install_begin

sgn_carefully mv -v "$SGN_PREFIX/bin/"{ld,ld-old}
sgn_carefully mv -v "$SGN_PREFIX/`gcc -dumpmachine`/bin/"{ld,ld-old}
sgn_carefully mv -v "$SGN_PREFIX/bin/"{ld-new,ld}
sgn_carefully ln -sv "$SGN_PREFIX/bin/ld" "$SGN_PREFIX/`gcc -dumpmachine`/bin/ld"

sgn_carefully_script							\
	"gcc -dumpspecs | sed 's@/lib/ld-linux.so.2@${SGN_PREFIX}&@g'	\
		> \`dirname \$(gcc -print-libgcc-file-name)\`/specs"

sgn_carefully_script
    "GCC_INCLUDEDIR=\`dirname \$(gcc -print-libgcc-file-name)\`/include   && \
    find \${GCC_INCLUDEDIR}/* -maxdepth 0 -xtype d -exec rm -rvf '{}' \;  && \
	rm -vf \`grep -l \"DO NOT EDIT THIS FILE\" \${GCC_INCLUDEDIR}/*\` && \
			 unset GCC_INCLUDEDIR"

sgn_carefully cd "$SGN_INSTALL"
sgn_carefully tar czf "$SGN_SGN_DIR/lfs-adjust-toolchain${SGN_PACKAGE_SUFFIX}.sgn" *
sgn_carefully cd "$SGN_HOME"

sgn_carefully sgn_install_end

sgn_finstat "lfs-adjust-toolchain"

