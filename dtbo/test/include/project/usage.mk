
define bar
$(shell printf "#%.0s" {1..47}; echo)
endef

define usage_str

##########################################
#                                        #
#                                        #
#                                        #
##########################################

Usage: 

  $ make all                         - build all device tree overlay
  $ make test.dtbo                   - build test device tree overlay

endef
export usage_str

usage help: 
	@echo "$${usage_str}" | more

