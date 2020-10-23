
define imginfoline
  printf "=%.s" {1..40} | sed "s/=/-/g"; printf "\n"; 
endef

define imginfo
  echo ;\
  if [ -e "$(img)" ] ; then \
    printf "%-20s : %s\n" "img" "$(img)"; \
    printf "%-20s : %s\n" "  img1" "$$( $(call rpiimginfo,$(img),1))"; \
    printf "%-20s : %s\n" "  img2" "$$( $(call rpiimginfo,$(img),2))"; \
    printf "%-20s : %s\n" "sector" "$$( $(call rpiimgsectorbytes,$(img))) bytes"; \
    $(call imginfoline) \
    printf "%-20s : \n" "boot"; \
    printf "%-20s : %s bytes\n" "  start" "$$( $(call rpiimgstart,$(img),1))"; \
    printf "%-20s : %s bytes\n" "  end" "$$( $(call rpiimgend,$(img),1))"; \
    printf "%-20s : %s bytes\n" "  sectors" "$$( $(call rpiimgsectors,$(img),1))"; \
    printf "%-20s : %s bytes\n" "  offset" "$$( $(call rpiimgoffset,$(img),1))"; \
    printf "%-20s : %s bytes\n" "  size" "$$( $(call rpiimgsize,$(img),1))"; \
    $(call imginfoline) \
    printf "%-20s : \n" "root"; \
    printf "%-20s : %s bytes\n" "  start" "$$( $(call rpiimgstart,$(img),2))"; \
    printf "%-20s : %s bytes\n" "  end" "$$( $(call rpiimgend,$(img),2))"; \
    printf "%-20s : %s bytes\n" "  sectors" "$$( $(call rpiimgsectors,$(img),2))"; \
    printf "%-20s : %s bytes\n" "  offset" "$$( $(call rpiimgoffset,$(img),2))"; \
    printf "%-20s : %s bytes\n" "  size" "$$( $(call rpiimgsize,$(img),2))"; \
  fi; \
  echo ;
endef

export info_str

.PHONY: info
info: 
	@$(call imginfo)

