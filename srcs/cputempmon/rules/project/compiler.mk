
$(compilerdir)/../.fetch_compiler:
	@git clone --depth=1 --branch $(compilerbranch) $(compilerurl) $(compilerdir)
	@touch $@

$(builddir)/.prepare_compiler: $(compilerdir)/../.fetch_compiler

.PHONY: compiler
compiler: $(builddir)/.prepare_compiler

