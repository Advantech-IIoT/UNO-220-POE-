.PHONY: clean
clean:
	@$(foreach t,$(build_targets),$(shell rm -rf $(builddir)/$(t)))

