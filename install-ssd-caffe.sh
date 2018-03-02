#!/bin/bash

#############################################################################
# INSTALL SINGLESHOT MULTIBOX DETECTOR BASED ON CAFFE ON UBUNTU OR DEBIAN   #
#############################################################################

if [ ! -z $1 ] && ([ $1 = '-h' ] || [ $1 = '--help' ]); then
	echo '
#*****************************************************************#
#    Usage:                                                       #
#       $ source install-ssd-caffe.sh                             #
#           (Set up for building in current directory)            #
#                                                                 #
#       $ WORK=<dir_name> source install-ssd-caffe.sh             #
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


INFO "Step 1. Install dependencies"
RUN sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
RUN sudo apt-get install --no-install-recommends libboost-all-dev
RUN sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev
RUN sudo apt-get install libatlas-base-dev
RUN sudo apt-get install libopenblas-dev

INFO "Step 2. Install Python dependencies"
RUN sudo -H pip install -U pip
RUN sudo apt-get install fort77 gfortran
RUN sudo apt-get install python-dev python-pip python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose
INFO ""
INFO ""

INFO "Step 3. Clone Single Shot Detector from repository"
RUN git clone https://github.com/weiliu89/caffe.git
RUN cd $WORK/caffe
RUN git checkout ssd
INFO ""
INFO ""

INFO "Step 4. Configure Caffe for installation (CPU only)"
RUN cd $WORK/caffe
RUN cp Makefile.config.example Makefile.config
sed -i "s/# CPU_ONLY := 1/CPU_ONLY := 1/" Makefile.config

INFO "Step 5. Install Python Dependencies"
RUN cd $WORK/caffe/python
for req in $(cat requirements.txt); do sudo pip install $req; done

INFO "Step 6. Export Python Path"
export PYTHONPATH=$WORK/caffe/python:$PYTHONPATH
INFO ""
INFO ""

INFO "Step 7. Make and Install"
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

INFO "Let's test the ssd by running it on webcam."
read

INFO "Download a pre-trained model from the link below"
INFO "https://drive.google.com/uc?id=0BzKzrI_SkD1_WVVTSmQxU0dVRzA&export=download"
INFO ""
INFO "Unzip the 'VGGNet' folder in $WORK/caffe/models"
INFO ""
INFO "Press Enter when done"
INFO ""
INFO ""
read

INFO "Please connect your webcam."
INFO "Press Enter when done."
read

INFO "Preparing example file to run only on CPU"
RUN cd $WORK/caffe/examples/ssd
INFO "Replacing Solver from GPU to CPU"
COMMAND "#sed -i 's/solver_mode = P.Solver.GPU/solver_mode = P.Solver.CPU/' ssd_pascal_webcam.py"
sed -i "s/solver_mode = P.Solver.GPU/solver_mode = P.Solver.CPU/" ssd_pascal_webcam.py
INFO ""
INFO ""

INFO "Please go to Caffe root folder"
COMMAND "#cd $WORK/caffe/"
RUN cd $WORK/caffe/
INFO ""

INFO "You can now run the following command:"
COMMAND "#python examples/ssd/ssd_pascal_webcam.py"

INFO "==================================================================="
INFO "Task completed."
INFO "==================================================================="
INFO ""
INFO ""
