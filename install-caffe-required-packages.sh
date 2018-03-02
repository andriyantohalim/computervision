#!/bin/bash

#*****************************************************************#
#    Automatically set up for building a RZG environment          #
#*****************************************************************#

if [ ! -z $1 ] && ([ $1 = '-h' ] || [ $1 = '--help' ]); then
	echo '
#*****************************************************************#
#    Usage:                                                       #
#       $ bash install-required-packages.sh                                     #
#*****************************************************************#'
	return 0      2>/dev/null || exit 0
fi

#### Pre-define functions for printing messages
function RUN {
	# Convinient function to Echo and Run a command line
	echo -e "${Yellow}$*${NC}"
	$*
	return $?
}

function INF {
	echo -e "    ${Light_Cyan}$*${NC}"
}

function ERR {
	echo -e "    ${Red}$*${NC}"
}

function COMMAND {
	echo -e "    ${Yellow}$*${NC}"
}
################################################

INF "Downloading and installing all necessary packages for Caffe"
IINFO "Step 1. Install dependencies"
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
