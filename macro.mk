##################################
# folders                        #
##################################
currdir=$(shell pwd)
builddir=$(shell realpath -m $(currdir)/build)
##################################
# image                          #
##################################
include images.info
# imgver: 20220404, 20230221
imgver=20230221
# imgtype=full     # Full Desktop image
# imgtype=         # Normal Desktop image
# imgtype=lite     # Lite image
imgtype=

imgname=$(img$(imgtype)name$(imgver))
zipimg=$(builddir)/download/$(imgname).zip
ifeq ($(imgver),20220404)
	zipimg=$(builddir)/download/$(imgname).xz
else ifeq ($(imgver),20230221)
	zipimg=$(builddir)/download/$(imgname).xz
endif
imgurl=$(img$(imgtype)url$(imgver))
releasedir=$(builddir)/release
mountdir=$(builddir)/mount
rootfs=$(mountdir)/root
bootfs=$(mountdir)/boot
img=$(releasedir)/$(imgname)
sector=512
rootclone=root20190926 rootAdvantech
bootclone=tpm
AdvVersion=V1.0.2_$(imgtype)_arm64
ifeq ($(imgtype), )
	AdvVersion=V1.0.2_arm64
endif
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
#export PATH:=$(compilerdir)/arm-bcm2708/arm-linux-gnueabihf/bin:$(PATH) 
export CROSS_COMPILE=aarch64-linux-gnu-
export HOSTCC=gcc
export CC=$(CROSS_COMPILE)gcc
export ARCH=arm64
export SHELL=/bin/bash
##################################
# dpkg                           #
##################################
#uno220config
dpkgconfigname=uno220config
dpkgconfigversion=0.1
dpkgconfigrevision=2
dpkgconfigarch=arm64
dpkgconfigdesc=Advantech UNO-220 (Raspberry Pi 4) IO Card RTC Package for config.txt and cmdline.txt
dpkgconfigeditor=Yuchun Chen <yuchun.chen@advantech.com.tw>
dpkgconfigdepends=sed (>=4.7-1)
#uno220rtc
dpkgrtcname=uno220rtc
dpkgrtcversion=0.1
dpkgrtcrevision=4
dpkgrtcarch=arm64
dpkgrtcdesc=Advantech UNO-220 (Raspberry Pi 4) IO Card RTC Package for EPSON RTC RX8010
dpkgrtceditor=Yuchun Chen <yuchun.chen@advantech.com.tw>
dpkgrtcdepends=sed (>=4.7-1)
dpkgrtcpredepends=raspberrypi-kernel (<=1:1.20230106-1)
#uno220gpio
dpkggpioname=uno220gpio
dpkggpioversion=0.1
dpkggpiorevision=2
dpkggpioarch=arm64
dpkggpiodesc=Advantech UNO-220 (Raspberry PI 4) IO Card GPIO EXPANDER for TI TCA9554
dpkggpioeditor=Yuchun Chen <yuchun.chen@advantech.com.tw>
dpkggpiodepends=sed (>=4.7-1)
#uno220uart
dpkguartname=uno220uart
dpkguartversion=0.1
dpkguartrevision=2
dpkguartarch=arm64
dpkguartdesc=Advantech UNO-220 (Raspberry PI 4) UART Tools
dpkguarteditor=Yuchun Chen <yuchun.chen@advantech.com.tw>
dpkguartdepends=sed (>=4.7-1)
