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
uno220uartrecv_target=uno220uartrecv
uno220uartrecv_sources=recv.c
uno220uartrecv_cc=$(CC)
uno220uartrecv_ld=$(LD)
uno220uartrecv_cflags=$(CFLAGS)
uno220uartrecv_ldflags=$(LDFLAGS)

host_recv_target=host_recv
host_recv_sources=recv.c
host_recv_cc=$(HOSTCC)
host_recv_ld=$(LD)
host_recv_cflags=$(CFLAGS)
host_recv_ldflags=$(LDFLAGS)

uno220uartsend_target=uno220uartsend
uno220uartsend_sources=send.c
uno220uartsend_cc=$(CC)
uno220uartsend_ld=$(LD)
uno220uartsend_cflags=$(CFLAGS)
uno220uartsend_ldflags=$(LDFLAGS)

host_send_target=host_send
host_send_sources=send.c
host_send_cc=$(HOSTCC)
host_send_ld=$(LD)
host_send_cflags=$(CFLAGS)
host_send_ldflags=$(LDFLAGS)

build_targets=uno220uartrecv host_recv
build_targets+=uno220uartsend host_send
