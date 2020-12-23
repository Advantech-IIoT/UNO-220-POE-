##################################
# folders                        #
##################################
currdir=$(shell pwd)
builddir=$(shell realpath -m $(currdir)/build)
##################################
# image                          #
##################################
include images.info
# imgver: 20190926, 20200205, 20200213, 20200527, 20200820
imgver=20200820
# imgtype=full     # Full Desktop image
# imgtype=         # Normal Desktop image
# imgtype=lite     # Lite image
imgtype=full
zipimg=$(builddir)/download/raspbian$(imgtype)$(imgver).img.zip
imgname=$(img$(imgtype)name$(imgver))
imgurl=$(img$(imgtype)url$(imgver))
releasedir=$(builddir)/release
mountdir=$(builddir)/mount
rootfs=$(mountdir)/root
bootfs=$(mountdir)/boot
img=$(releasedir)/$(imgname)
sector=512
rootclone=root20190926 rootAdvantech
bootclone=tpm
##################################
# kernel                         #
##################################
kernelversion=$(kernelversion$(imgver))
kerneldefconfig=$(kerneldefconfig$(imgver))
kernelconfig=$(kernelconfig$(imgver))
kernelgiturl=https://github.com/raspberrypi/linux.git
# kernelbranch=$(kernelbranch$(imgver))
kernelbranch=$(kernel$(kernelversion)branch)
kerneldir=$(shell realpath -m $(builddir)/kernel/$(kernelversion)/src)
kbuilddir=$(shell realpath -m $(builddir)/kernel/$(kernelversion)/build)
allkernelversions=$(shell for v in $(foreach kv,$(filter kernelversion%,$(.VARIABLES)),$($(kv))); do echo $$v; done | sort | uniq)
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
##################################
# dpkg                           #
##################################
dpkgconfigname=uno220config
dpkgconfigversion=0.1
dpkgconfigrevision=2
dpkgconfigarch=armhf
dpkgconfigdesc=Advantech UNO-220 (Raspberry Pi 4) IO Card RTC Package for config.txt and cmdline.txt
dpkgconfigeditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkgconfigdepends=sed (>=4.7-1)
dpkgrtcname=uno220rtc
dpkgrtcversion=0.1
dpkgrtcrevision=2
dpkgrtcarch=armhf
dpkgrtcdesc=Advantech UNO-220 (Raspberry Pi 4) IO Card RTC Package for EPSON RTC RX8010
dpkgrtceditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkgrtcdepends=sed (>=4.7-1)
dpkgrtcpredepends=raspberrypi-kernel (<=1.20201022-1)
dpkggpioname=uno220gpio
dpkggpioversion=0.1
dpkggpiorevision=2
dpkggpioarch=armhf
dpkggpiodesc=Advantech UNO-220 (Raspberry PI 4) IO Card GPIO EXPANDER for TI TCA9554 
dpkggpioeditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkggpiodepends=sed (>=4.7-1)
dpkguartname=uno220uart
dpkguartversion=0.1
dpkguartrevision=2
dpkguartarch=armhf
dpkguartdesc=Advantech UNO-220 (Raspberry PI 4) UART Tools
dpkguarteditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkguartdepends=sed (>=4.7-1)
