#!/bin/bash

######################################
# INSTALL OPENCV ON UBUNTU OR DEBIAN #
######################################

if [ ! -z $1 ] && ([ $1 = '-h' ] || [ $1 = '--help' ]); then
	echo '
#*****************************************************************#
#    Usage:                                                       #
#       $ source install-dlib.sh                                  #
#           (Set up for building in current directory)            #
#                                                                 #
#       $ WORK=<dir_name> source install-dlib.sh                  #
#           (Set up for building in another directory <dir_name>) #
#*****************************************************************#'
	return 0      2>/dev/null || exit 0
fi

#### Pre-defined color code
Red='\033[0;31m'
Black='\033[0;30m'
Dark_Gray='\033[1;30m'
Red='\033[0;31m'
Light_Red='\033[1;31m'
Green='\033[0;32m'
Light_Green='\033[1;32m'
Brown_Orange='\033[0;33m'
Yellow='\033[1;33m'
Blue='\033[0;34m'
Light_Blue='\033[1;34m'
Purple='\033[0;35m'
Light_Purple='\033[1;35m'
Cyan='\033[0;36m'
Light_Cyan='\033[1;36m'
Light_Gray='\033[0;37m'
White='\033[1;37m'
NC='\033[0m'
##########################


#### Pre-defined functions for printing messages
function RUN {
	echo -e "${Yellow}$*${NC}"
	$*
	return $?
}

function INFO {
	echo -e "${Light_Cyan}$*${NC}"
}

function ERROR {
	echo -e "	${Red}$*${NC}"
}

function COMMAND {
	echo -e "	${Yellow}$*${NC}"
}
################################################

if [ -z $WORK ]; then WORK=$PWD;fi

INFO "Step 1. Update Ubuntu/Debian"
RUN sudo apt-get -y update
RUN sudo apt-get -y upgrade
RUN sudo apt-get -y dist-upgrade
RUN sudo apt-get -y autoremove
INFO ""
INFO ""

INFO "Step 2. Install dependencies"
INFO ""
INFO "Step 2a. Install Build Tools"
RUN sudo apt-get install -y build-essential cmake
INFO ""
INFO ""

INFO "Step 2b. Install GUI dependencies"
RUN sudo apt-get install -y qt5-default libvtk6-dev
INFO ""
INFO ""

INFO "Step 2c. Install Media dependencies"
RUN sudo apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev
INFO ""
INFO ""

INFO "Step 2d. Install Video dependencies"
RUN sudo apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev
INFO ""
INFO ""

INFO "Step 2e. Install Linear Algebra and parallelism"
RUN sudo apt-get install -y libtbb-dev libeigen3-dev
INFO ""
INFO ""

INFO "Step 2f. Install Python dependencies"
RUN sudo apt-get install -y python-dev python-tk python-numpy python3-dev python3-tk python3-numpy
INFO ""
INFO ""

INFO "Step 2g. Install Java dependencies"
RUN sudo apt-get install -y ant default-jdk
INFO ""
INFO ""

INFO "Step 2h. Install Documentation dependencies"
RUN sudo apt-get install -y doxygen
INFO ""
INFO ""

INFO "Step 2i. Install optional dependencies"
RUN sudo apt-get install -y libprotobuf-dev protobuf-compiler
RUN sudo apt-get install -y libgoogle-glog-dev libgflags-dev
RUN sudo apt-get install -y libgphoto2-dev libhdf5-dev 
RUN sudo apt-get install -y unzip wget
INFO ""
INFO ""

INFO "Step 3. Clone OpenCV from repository"
RUN git clone https://github.com/opencv/opencv.git
RUN cd $WORK/opencv
RUN git checkout 3.3.1
INFO ""
INFO ""

INFO "Step 4. Build and install OpenCV"
RUN mkdir $WORK/opencv/build
RUN cd $WORK/opencv/build
RUN cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON -DENABLE_PRECOMPILED_HEADERS=OFF ..
var=$(nproc)
RUN make -j$var
RUN sudo make install
RUN sudo ldconfig
INFO ""
INFO ""

INFO "==================================================================="
INFO "Installation is completed."
INFO "==================================================================="
INFO ""
INFO "Go to the following folder to find the executables"
COMMAND "#cd $WORK/opencv/build/bin"

INFO "Run an example, e.g:"
COMMAND "#./cpp-example-image ../../samples/data/lena.jpg"
COMMAND "#./cpp-example-image ../../samples/data/fruits.jpg"
COMMAND "#./cpp-example-facedetect"

