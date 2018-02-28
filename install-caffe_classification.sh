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

INFO "Make sure you have install Caffe prior to running this script"
COMMAND "#source install-caffe.sh"
INFO "Press Enter to continue, Ctrl+C to exit"
INFO ""
INFO ""
read

RUN cd $WORK/caffe

INFO "Getting pre-trained CaffeNet model"
RUN ./scripts/download_model_binary.py $WORK/caffe/models/bvlc_reference_caffenet

INFO ""
INFO ""

INFO "Getting pre-trained CaffeNet model"
RUN ./data/ilsvrc12/get_ilsvrc_aux.sh
INFO ""
INFO ""


INFO "Classify! ..."
RUN ./build/examples/cpp_classification/classification.bin \
  $WORK/caffe/models/bvlc_reference_caffenet/deploy.prototxt \
  $WORK/caffe/models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel \
  $WORK/caffe/data/ilsvrc12/imagenet_mean.binaryproto \
  $WORK/caffe/data/ilsvrc12/synset_words.txt \
  $WORK/caffe/examples/images/cat.jpg
INFO ""
INFO ""

INFO "==================================================================="
INFO "Task completed."
INFO "==================================================================="
INFO ""
INFO ""

INFO "More info on http://caffe.berkeleyvision.org/tutorial/"

