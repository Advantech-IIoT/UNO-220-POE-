
define compilesrcspattern
.PHONY: $(1)
$(1): $(builddir)/$(1)/.build

$(builddir)/$(1): 
	@mkdir -p $$@

$(builddir)/$(1)/.build: $(builddir)/$(1) $(builddir)/.prepare_compiler $(builddir)/$(1)/.prepare $(builddir)/$(1)/.compile

$(builddir)/$(1)/.prepare: $(builddir)/$(1)/.fetch

$(builddir)/$(1)/.fetch: 
	@tar -C $(currdir)/srcs/$(1) -zcpf - . | tar -C $(builddir)/$(1) -zxpf - 
	@touch $$@

$(builddir)/$(1)/.compile: 
	@make -C $(builddir)/$(1) build

.PHONY: $(1)_clean
$(1)_clean:
	@rm -rf $(builddir)/$(1)
endef

$(eval $(call compilesrcspattern,mcast))

