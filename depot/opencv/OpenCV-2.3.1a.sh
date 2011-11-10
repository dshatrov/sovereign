PACKAGE_NAME="opencv"
PACKAGE_VERNAME="OpenCV-2.3.1a"

PACKAGE_ARCHIVE="${PACKAGE_VERNAME}.tar.bz2"
PACKAGE_DIR="OpenCV-2.3.1"

sgn_carefully sgn_untar_bz2

#sgn_carefully sgn_builddir sgn_byuser cmake -DCMAKE_PREFIX_PATH=$SGN_PREFIX -DCMAKE_INSTALL_PREFIX=$SGN_PREFIX .

sgn_carefully sgn_builddir sgn_byuser cmake	\
	-DCMAKE_PREFIX_PATH=/opt/moment		\
	-DCMAKE_INSTALL_PREFIX=/opt/moment	\
	-DWITH_GTK=OFF				\
	-DWITH_V4L=OFF				\
	-DWITH_1394=OFF				\
	-DWITH_OPENEXR=OFF			\
	-DWITH_PVAPI=OFF			\
	-DWITH_EIGEN=OFF			\
	-DWITH_CUDA=OFF				\
	-DBUILD_DOCS=OFF			\
	-DBUILD_NEW_PYTHON_SUPPORT=OFF		\
	-DWITH_VIDEOINPUT=OFF			\
	-DBUILD_TESTS=OFF			\
	.

sgn_carefully sgn_builddir sgn_byuser make -j 4
sgn_carefully sgn_make_install

sgn_carefully sgn_cleanup
sgn_finstat

