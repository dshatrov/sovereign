PACKAGE_NAME="rtmpdump"
PACKAGE_VERNAME="rtmpdump-2.3"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tgz"
PACKAGE_DIR="${PACKAGE_VERNAME}"

sgn_carefully sgn_untar_gz

sgn_carefully sgn_builddir sgn_byuser sh -c "echo \"INC=-I$SGN_PREFIX/include\" > Makefile.new"
sgn_carefully sgn_builddir sgn_byuser sh -c "echo \"XLDFLAGS=-L$SGN_PREFIX/lib\" >> Makefile.new"
sgn_carefully sgn_builddir sgn_byuser sh -c "echo \"prefix=$SGN_PREFIX\" >> Makefile.new && cat Makefile | sed \"s/^prefix=.*//\" >> Makefile.new && cp Makefile.new Makefile"

sgn_carefully sgn_builddir sgn_byuser sh -c "echo \"INC=-I$SGN_PREFIX/include\" > librtmp/Makefile.new"
sgn_carefully sgn_builddir sgn_byuser sh -c "echo \"LDFLAGS=-L$SGN_PREFIX/lib\" >> librtmp/Makefile.new"
sgn_carefully sgn_builddir sgn_byuser sh -c "echo \"prefix=$SGN_PREFIX\" >> librtmp/Makefile.new && cat librtmp/Makefile | sed \"s/^prefix=.*//\" >> librtmp/Makefile.new && cp librtmp/Makefile.new librtmp/Makefile"

sgn_carefully sgn_builddir sgn_byuser make
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

