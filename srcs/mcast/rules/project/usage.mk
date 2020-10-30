
define bar
$(shell printf "#%.0s" {1..47}; echo)
endef

define usage_str

##########################################
#                                        #
#          mcast server/client           #
#                                        #
##########################################

Usage: 

  $ make                             - show this usage
  $ make help                        - show this usage
  $ make build                       - build all sources             

endef
export usage_str

usage help: 
	@echo "$${usage_str}" | more

