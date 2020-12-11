
define dtborule
.PHONY: $(1).dtbo
$(1).dtbo: $(builddir) $(builddir)/$(1).dtbo

$(builddir)/$(1).dtbo: 
	@dtc -I dts -O dtb $(currdir)/$(1).dts > $${@}
endef

$(foreach dts,$(wildcard $(currdir)/*.dts),$(eval $(call dtborule,$(shell basename $(dts) | sed -e 's/.dts$$//'))))
