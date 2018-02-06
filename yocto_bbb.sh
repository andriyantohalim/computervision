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

INFO "Step 2. Install necessary dependencies"
RUN sudo apt-get install -y build-essential chrpath diffstat gawk libncurses5-dev texinfo
INFO ""
INFO ""

INFO "Step 3. Clone poky-rocko"
RUN git clone -b rocko git://git.yoctoproject.org/poky.git poky-rocko
INFO ""
INFO ""

INFO "Step 4. Clone meta-openembedded"
RUN git clone -b rocko git://git.openembedded.org/meta-openembedded
INFO ""
INFO ""

INFO "Step 5. Clone meta-qt5"
RUN git clone -b rocko https://github.com/meta-qt5/meta-qt5.git
INFO ""
INFO ""

INFO "Step 6. Clone meta-linaro"
RUN git clone -b rocko https://github.com/linaro-home/meta-linaro
INFO ""
INFO ""

INFO "Step 7. Clone meta-bbb"
RUN git clone -b rocko git://github.com/jumpnow/meta-bbb
INFO ""
INFO ""

INFO "Step 8. Initialize build environment"
RUN source $WORK/poky-rocko/oe-init-build-env $WORK/build
INFO ""
INFO ""

INFO "You can now run the following command to start bitbake"
COMMAND "#bitbake core-image-minimal"
INFO "Bitbake will take some time depending on your system specs and internet connection."
INFO "In case you see an error, run the following command:"
COMMAND "#bitbake -c cleansstate.file && bitbake file"
INFO ""
INFO ""
