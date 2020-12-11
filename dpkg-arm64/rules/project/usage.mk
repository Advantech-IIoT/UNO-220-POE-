
define bar
$(shell printf "#%.0s" {1..47}; echo)
endef

define usage_str

##########################################
#                                        #
#        UNO-220 Package Maker           #
#                                        #
##########################################

Usage: 

  $ make                             - Show this usage               
  $ make dpkg                        - Build UNO-220 Debian Package 
  $ make clean                       - Clean build folder

endef
export usage_str

usage help: 
	@echo "$${usage_str}" | more

