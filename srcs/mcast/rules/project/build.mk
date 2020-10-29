
define buildrulesprepare
$(1)_objs=$(foreach s,$($(1)_sources),$(builddir)/$(1)/$(patsubst %.c,%.o,.$(1)_$(s)))
endef
define objruletemplate
$(builddir)/$(1)/$(patsubst %.c,%.o,.$(1)_$(2)): $(srcsdir)/$(2)
	@$($(1)_cc) $($(1)_cflags) -o $$@ -c $$<
endef
define buildrulestemplate
$(eval $(call buildrulesprepare,$(1)))
.PHONY: $(1)
$(1): $(builddir)/$(1) $(builddir)/$(1)/.prepare_$(1) $(builddir)/$(1)/.compile_source_$(1) $(builddir)/$(1)/.compile_$(1)

$(builddir)/$(1): 
	@mkdir -p $$@

$(builddir)/$(1)/.prepare_$(1): 
	@cp -a $(foreach s,$($(1)_sources),$(srcsdir)/$(s)) $(builddir)/$(1)
	@touch $$@


$(builddir)/$(1)/.compile_source_$(1): $($(1)_objs)
	@$(1)_objs=$($(1)_objs)

$(foreach s,$($(1)_sources),$(eval $(call objruletemplate,$(1),$(s))))

$(builddir)/$(1)/.compile_$(1): 
	@$($(1)_cc) $($(1)_ldflags) -o $(builddir)/$(1)/$($(1)_target) $($(1)_objs)

endef

$(foreach t,$(build_targets),$(eval $(call buildrulestemplate,$(t))))

.PHONY: build
build: $(build_targets)
