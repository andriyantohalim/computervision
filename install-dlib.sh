#!/bin/bash

######################################
# INSTALL DLIB ON UBUNTU OR DEBIAN   #
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
RUN sudo apt-get install -y git
RUN sudo apt-get install -y build-essential cmake ..
INFO ""
INFO ""


INFO "Step 3. Clone dlib from repository"
RUN git clone https://github.com/davisking/dlib
INFO ""
INFO ""


INFO "Step 4. Compile C++ example program"
RUN cd $WORK/dlib/examples
RUN mkdir build
RUN cd build 
RUN cmake ..
var=$(nproc)
RUN make -j$var
RUN cmake --build . --config Release
INFO ""
INFO ""


INFO "Step 5. Download pre-trained models to be used for the examples"
RUN cd $WORK/dlib/examples
RUN git clone https://github.com/davisking/dlib-models
RUN cd dlib-models
RUN bzip2 -d *.bz2
INFO ""
INFO ""


INFO "==================================================================="
INFO "Installation is completed."
INFO "==================================================================="
INFO ""
INFO "Go to the following folder to find the executables"
COMMAND "#cd $WORK/dlib/examples/build/"

INFO "Run an example, e.g:"
COMMAND "#./dnn_mmod_face_detection_ex ../dlib-models/mmod_human_face_detector.dat ../faces/*.jpg"




