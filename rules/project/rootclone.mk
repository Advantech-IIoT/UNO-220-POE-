
.PHONY: rootclone
rootclone: $(builddir)/.rootclone

define rootclonetemplate
$(builddir)/.rootclone_$(1): $(rootfs)
	@( tar -C $(currdir)/srcs/root/$(1) --numeric-owner -zcpvf - . | tar -C $(rootfs) -h -zxpvf - ) > /dev/null 2>&1
endef

$(foreach r,$(rootclone),$(eval $(call rootclonetemplate,$(r))))

$(builddir)/.rootclone: $(foreach r,$(rootclone),$(builddir)/.rootclone_$(r))

