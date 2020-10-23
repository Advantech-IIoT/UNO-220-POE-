
$(builddir)/.prepare_kernel: $(builddir)/.fetch_kernel \
                             $(builddir)/.config_kernel \
                             $(builddir)/.modules_prepare_kernel

$(builddir)/.fetch_kernel: 
	@git clone --depth=1 --branch $(kernelbranch) $(kernelgiturl) $(kerneldir)
	@touch $@

$(builddir)/.config_kernel: 
	@make -C $(kerneldir) O=$(kbuilddir) ARCH=$(ARCH) $(kerneldefconfig)
	@touch $@

$(builddir)/.modules_prepare_kernel: 
	@make -C $(kerneldir) O=$(kbuilddir) ARCH=$(ARCH) modules_prepare
	@touch $@

$(builddir)/.zimage_kernel: 
	@make -C $(kerneldir) O=$(kbuilddir) ARCH=$(ARCH) zImage

.PHONY: menuconfig
menuconfig: $(builddir)/.prepare_kernel
	@make -C $(kerneldir) O=$(kbuilddir) ARCH=$(ARCH) menuconfig TERM=vt100

.PHONY: prepare_kernel
prepare_kernel: $(builddir)/.prepare_kernel

