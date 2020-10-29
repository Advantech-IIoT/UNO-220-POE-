builddir=$(currdir)/build
srcsdir=$(currdir)/srcs
incdir=$(currdir)/inc
##################################
# compiler                       #
##################################
compilerdir=$(shell realpath -m $(currdir)/../../build/compiler)
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
mcastserver_target=mcastserver
mcastserver_sources=mcastserver.c
mcastserver_cc=$(CC)
mcastserver_ld=$(LD)
mcastserver_cflags=$(CFLAGS)
mcastserver_ldflags=$(LDFLAGS)
mcastcli_target=mcastcli
mcastcli_sources=mcastcli.c
mcastcli_cc=$(HOSTCC)
mcastcli_ld=$(HOSTLD)
mcastcli_cflags=$(CFLAGS)
mcastcli_ldflags=$(LDFLAGS)
mcastserver2_target=mcastserver2
mcastserver2_sources=mcastserver2.c
mcastserver2_cc=$(CC)
mcastserver2_ld=$(LD)
mcastserver2_cflags=$(CFLAGS)
mcastserver2_ldflags=$(LDFLAGS)
mcastcli2_target=mcastcli2
mcastcli2_sources=mcastcli2.c
mcastcli2_cc=$(HOSTCC)
mcastcli2_ld=$(HOSTLD)
mcastcli2_cflags=$(CFLAGS)
mcastcli2_ldflags=$(LDFLAGS)
build_targets=mcastserver mcastcli
build_targets+=mcastserver2 mcastcli2

