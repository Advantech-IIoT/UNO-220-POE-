
_topdirs=$(shell find . -mindepth 1 -maxdepth 1 -type d -not -name ".git*" -not -name "build" -printf "%P\n")

define buildrules
.PHONY: $(1)
$(1): 
	@make -C $(1) $(1)
.PHONY: clean_$(1)
$(1)_clean: 
	@make -C $(1) $(1)_clean
endef

all: $(_topdirs)

clean: 
	@rm -rf build

$(foreach _d,$(_topdirs),$(eval $(call buildrules,$(_d))))

