.PHONY: test
test: 
	@echo $(foreach dts,$(wildcard $(currdir)/*.dts),$(shell basename $(dts)))
	@echo $(foreach dts,$(wildcard $(currdir)/*.dts),$(shell basename $(dts) | sed -e 's/.dts$$//'))
