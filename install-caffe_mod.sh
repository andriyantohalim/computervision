#!/bin/bash

######################################
# INSTALL CAFFE ON UBUNTU OR DEBIAN   #
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


INFO "Step 1a. Install dependencies"
RUN sudo apt-get install fort77 gfortran
RUN sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
RUN sudo apt-get install --no-install-recommends libboost-all-dev
RUN sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev
RUN sudo apt-get install libatlas-base-dev
RUN sudo apt-get install libopenblas-dev

INFO "Step 1b. Install Python dependencies"
RUN sudo apt-get install python-dev python-pip python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose
INFO ""
INFO ""


INFO "Step 3. Clone dlib from repository"
RUN git clone https://github.com/BVLC/caffe.git
INFO ""
INFO ""


INFO "Step 4. Configure Caffe for installation (CPU only)"
RUN cd $WORK/caffe
RUN cp Makefile.config.example Makefile.config
sed -i "s/# CPU_ONLY := 1/CPU_ONLY := 1/" Makefile.config

RUN cd $WORK/caffe/python
for req in $(cat requirements.txt); do sudo pip install $req; done
export PYTHONPATH=$WORK/caffe/python:$PYTHONPATH
INFO ""
INFO ""


INFO "Step 5. Install Python Dependencies"
RUN cd $WORK/caffe
var=$(nproc)
RUN sudo make all -j$var
RUN sudo make pycaffe
RUN sudo make test -j$var
RUN sudo make runtest -j$var


INFO "==================================================================="
INFO "Installation is completed."
INFO "==================================================================="
INFO ""
INFO ""

