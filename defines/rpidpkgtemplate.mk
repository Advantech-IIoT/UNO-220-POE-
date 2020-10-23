
define rpidpkgtemplate

.PHONY: rpidpkg$(1)
rpidpkg$(1): $(builddir)/dpkg/.fetch_rpidpkg$(1) $(builddir)/dpkg/.patch_rpidpkg$(1) $(builddir)/dpkg/.postpatch_rpidpkg$(1) $(builddir)/dpkg/.build_rpidpkg$(1)
	
$(builddir)/dpkg/.fetch_rpidpkg$(1): $(builddir)
	@mkdir -p $(builddir)/dpkg
	@cp -a $(currdir)/srcs/dpkg/$(1) $(builddir)/dpkg
	@touch $$@

$(builddir)/dpkg/.patch_rpidpkg$(1): 
	@sed -i "s/__name__/$(dpkg$(1)name)/" $(builddir)/dpkg/$(1)/DEBIAN/*
	@sed -i "s/__version__/$(dpkg$(1)version)/" $(builddir)/dpkg/$(1)/DEBIAN/*
	@sed -i "s/__revision__/$(dpkg$(1)revision)/" $(builddir)/dpkg/$(1)/DEBIAN/*
	@sed -i "s/__arch__/$(dpkg$(1)arch)/" $(builddir)/dpkg/$(1)/DEBIAN/*
	@sed -i "s/__desc__/$(dpkg$(1)desc)/" $(builddir)/dpkg/$(1)/DEBIAN/*
	@sed -i "s/__editor__/$(dpkg$(1)editor)/" $(builddir)/dpkg/$(1)/DEBIAN/*
	@sed -i "s/__depends__/$(dpkg$(1)depends)/" $(builddir)/dpkg/$(1)/DEBIAN/*
	@touch $$@

$(builddir)/dpkg/.postpatch_rpidpkg$(1): 

$(builddir)/dpkg/.build_rpidpkg$(1):
	@dpkg --build $(builddir)/dpkg/$(1) $(builddir)

$(builddir)/dpkg/.install_rpidpkg$(1): 
	@[ -f "$(builddir)/$(dpkg$(1)name)_$(dpkg$(1)version)-$(dpkg$(1)revision)_$(dpkg$(1)arch).deb" ] && dpkg --install $(builddir)/$(dpkg$(1)name)_$(dpkg$(1)version)-$(dpkg$(1)revision)_$(dpkg$(1)arch).deb

endef

$(eval $(call rpidpkgtemplate,rtc))

$(builddir)/dpkg/.postpatch_rpidpkgrtc: 
	@make modules_install_rtc rootfs=$(builddir)/dpkg/rtc
	@sed -i "s/__kernel_version__/$(kernelversion)/" $(builddir)/dpkg/rtc/DEBIAN/*

$(eval $(call rpidpkgtemplate,gpio))
$(eval $(call rpidpkgtemplate,uart))

