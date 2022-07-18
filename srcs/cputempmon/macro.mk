builddir=$(shell realpath -m $(currdir)/../../build)
srcsdir=$(currdir)/srcs
incdir=$(currdir)/inc
##################################
# compiler                       #
##################################
compilerdir=$(builddir)/compiler
compilerurl=https://github.com/raspberrypi/tools.git 
compilerbranch=master
##################################
# env                            #
##################################
#export PATH:=$(compilerdir)/arm-bcm2708/arm-linux-gnueabihf/bin:$(PATH) 
export CROSS_COMPILE=aarch64-linux-gnu-
export HOSTCC=gcc
export HOSTLD=ld
export CC=$(CROSS_COMPILE)gcc
export LD=$(CROSS_COMPILE)ld
export ARCH=arm64
export SHELL=/bin/bash
CFLAGS=-Wall -I$(incdir)
LDFLAGS=
##################################
# target / sources / flags       #
##################################
cputempmon_target=cputempmon
cputempmon_sources=cputempmon.c
cputempmon_cc=$(CC)
cputempmon_ld=$(LD)
cputempmon_cflags=$(CFLAGS)
cputempmon_ldflags=$(LDFLAGS)

build_targets=cputempmon
