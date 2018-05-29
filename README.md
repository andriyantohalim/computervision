# Speed up your computer vision and deep learning projects using these installation scripts!

Starting a computer vision project must not always be done from scratch. Plenty of computer vision/deep learning projects make use the existing open-source frameworks, such as [OpenCV](https://opencv.org/), [Caffe](http://caffe.berkeleyvision.org/) and [dlib](http://dlib.net/).

Installing these frameworks, however, can sometimes be very frustating due to unclear documentations and missing dependencies. The following shell scripts in this repository address such issue by helping the users to automate the installation of the frameworks.


## IMPORTANT
There is a compatibility issue when CUDA exists in the machine. The scrips usually will fail. Work in progress.

## Getting Started
Open the terminal and clone this repository:
```
git clone https://github.com/andriyantohalim/computervision
```

## Install OpenCV
To install OpenCV, run the following command in the terminal:
```
bash install-opencv.sh
```

## Install dlib
To install dlib, run the following command:
```
bash install-dlib.sh
```

## Install Caffe
To install Caffe, two steps are required:
1. Install Caffe dependencies.
Run the following command in the terminal:
```
source install-caffe-required-packages.sh
```
2. Install Caffe. 
Run the following command in the terminal:
```
source install-caffe.sh
```

## Install Caffe examples
There are 3 example projects supported by these scripts, namely LeNet, Classification and [Single Shot Detector (SSD)](https://github.com/weiliu89/caffe.git). 
It is recommended for you to complete the above Caffe installation before proceeding with these examples.
1. Install LeNet example
```
source install-caffe_lenet.sh
```

2. Install Classification project
```
source install-caffe_classification.sh
```

3. Install Single Shot Detector
```
source install-ssd-caffe.sh
```

