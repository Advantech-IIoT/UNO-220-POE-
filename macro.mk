##################################
# folders                        #
##################################
currdir=$(shell pwd)
builddir=$(shell realpath -m $(currdir)/build)
rootfs=$(shell realpath -m $(builddir)/root)
##################################
# image                          #
##################################
# imgurl20200213=http://downloads.raspberrypi.org/raspbian_full/images/raspbian_full-2020-02-14/2020-02-13-raspbian-buster-full.zip
# imgname20200213=2020-02-13-raspbian-buster-full.img
# imgname20190926=2019-09-26-raspbian-buster-full.img
# imgurl20190926=http://downloads.raspberrypi.org/raspbian_full/images/raspbian_full-2019-09-30/2019-09-26-raspbian-buster-full.zip
# imgname=2019-09-26-raspbian-buster-full.img
# imgurl=http://downloads.raspberrypi.org/raspbian_full/images/raspbian_full-2019-09-30/2019-09-26-raspbian-buster-full.zip
include images.info
# imgver=20190926
# imgver=20200213
# imgver=20200527
imgver=20200820
imgtype=full
zipimg=$(builddir)/raspbian$(imgtype)$(imgver).img.zip
imgname=$(img$(imgtype)name$(imgver))
imgurl=$(img$(imgtype)url$(imgver))
img=$(builddir)/$(imgname)
sector=512
rootclone=$(rootclone$(imgver))
##################################
# kernel                         #
##################################
kerneldir=$(shell realpath -m $(builddir)/kernel)
kbuilddir=$(shell realpath -m $(builddir)/kbuild)
# kernelversion=4.19.75-v7l+
kernelversion=$(kernelversion$(imgver))
kerneldefconfig=$(kerneldefconfig$(imgver))
kernelconfig=$(kernelconfig$(imgver))
kernelgiturl=https://github.com/raspberrypi/linux.git
kernelbranch=$(kernelbranch$(imgver))
##################################
# compiler                       #
##################################
compilerdir=$(shell realpath -m $(builddir)/compiler)
compilerurl=https://github.com/raspberrypi/tools.git 
compilerbranch=master
##################################
# env                            #
##################################
export PATH:=$(compilerdir)/arm-bcm2708/arm-linux-gnueabihf/bin:$(PATH) 
export CROSS_COMPILE=arm-linux-gnueabihf-
export HOSTCC=gcc
export CC=$(CROSS_COMPILE)gcc
export ARCH=arm
export SHELL=/bin/bash

