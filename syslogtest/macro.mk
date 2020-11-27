builddir=$(shell realpath -m $(currdir)/../build)
srcsdir=$(currdir)/srcs
incdir=$(currdir)/inc
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
export HOSTLD=ld
export CC=$(CROSS_COMPILE)gcc
export LD=$(CROSS_COMPILE)ld
export ARCH=arm
export SHELL=/bin/bash
CFLAGS=-Wall -I$(incdir)
LDFLAGS=
##################################
# target / sources / flags       #
##################################
syslogtest_target=syslogtest
syslogtest_sources=syslogtest.c
syslogtest_cc=$(CC)
syslogtest_ld=$(LD)
syslogtest_cflags=$(CFLAGS)
syslogtest_ldflags=$(LDFLAGS)

build_targets=syslogtest
