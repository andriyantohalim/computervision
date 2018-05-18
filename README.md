# Speed up your computer vision and deep learning projects with the following automatic installation scripts!

Starting a computer vision project must not always be done from scratch. Plenty of computer vision/deep learning projects make use the existing open-source frameworks, such as [OpenCV](https://opencv.org/), [Caffe](http://caffe.berkeleyvision.org/) and [dlib](http://dlib.net/).

Installing these frameworks, however, can sometimes be very frustating due to unclear documentations and missing dependencies. The following shell scripts in this repository address such issue by helping the users to automate the installation of the frameworks.

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

## Install Caffe
To install Caffe, two steps are required:
1. Install Caffe dependencies.
Run the following command in the terminal:
```
source install-caffe-required-packages.sh
```
2. Install Caff. 
Run the following command in the terminal:
```
source install-caffe.sh
```

## Install dlib
To install dlib, run the following command:
```
bash install-dlib.sh
```
