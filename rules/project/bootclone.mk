
.PHONY: bootclone
bootclone: $(builddir)/.bootclone

define bootclonetemplate
$(builddir)/.bootclone_$(1): $(bootfs)
	@( tar -C $(currdir)/srcs/boot/$(1) --numeric-owner --no-same-owner -zcpvf - . | tar -C $(bootfs) --no-same-owner -zxpvf - ) > /dev/null 2>&1
endef

$(foreach r,$(bootclone),$(eval $(call bootclonetemplate,$(r))))

$(builddir)/.bootclone: $(foreach r,$(bootclone),$(builddir)/.bootclone_$(r))

