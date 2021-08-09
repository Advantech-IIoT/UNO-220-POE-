
.PHONY: fetch_img
fetch_img: $(releasedir) $(releasedir)/.fetch_img $(releasedir)/.unpack_img

$(releasedir): 
	@mkdir -p $@

$(releasedir)/.fetch_img: $(zipimg)

$(zipimg): 
	@$(call downloadfile,$(imgurl),$(zipimg))

$(releasedir)/.unpack_img: $(img)

$(img): 
	@cd $(releasedir) && unzip $(zipimg)

.PHONY: clean_img
clean_img: 
	@if [ -d $(releasedir) ] ; then \
          cd $(releasedir) && rm -rf $(imgname)*; \
	fi

.PHONY: mount_img
mount_img: 
	@$(call mountrpiimg)

.PHONY: umount_img
umount_img: 
	@$(call umountrpiimg)

.PHONY: mount_dpkg_img
mount_dpkg_img: 
	@$(call mountrpiimgsel,$(mountdir)/root,2)
	@$(call mountrpiimgsel,$(mountdir)/root/boot,1)

.PHONY: umount_dpkg_img
umount_dpkg_img: 
	@$(call umountrpiimgsel,$(mountdir)/root/boot,1)
	@$(call umountrpiimgsel,$(mountdir)/root,2)

.PHONY: enable_i2c_config
enable_i2c_config:
	@$(call rpienablei2cconfig,$(mountdir)/boot/config.txt)

.PHONY: disable_i2c_config
disable_i2c_config:
	@$(call rpidisablei2cconfig,$(mountdir)/boot/config.txt)

.PHONY: enable_spi_config
enable_spi_config:
	@$(call rpienablespiconfig,$(mountdir)/boot/config.txt)

.PHONY: disable_spi_config
disable_spi_config:
	@$(call rpidisablespiconfig,$(mountdir)/boot/config.txt)

.PHONY: enable_tpm_config
enable_tpm_config:
	@$(call rpienabletpmconfig,$(mountdir)/boot/config.txt)

.PHONY: disable_tpm_config
disable_tpm_config:
	@$(call rpidisabletpmconfig,$(mountdir)/boot/config.txt)

.PHONY: enable_uno220gpio_config
enable_uno220gpio_config:
	@$(call rpienableuno220gpioconfig,$(mountdir)/boot/config.txt)

.PHONY: disable_uno220gpio_config
disable_uno220gpio_config:
	@$(call rpidisableuno220gpioconfig,$(mountdir)/boot/config.txt)

.PHONY: enable_TPM_setting
enable_TPM_setting:
	@$(call enableTPMsetting,$(mountdir)/root/etc/rc.local)

.PHONY: enable_console_cmdline
enable_console_cmdline:
	@$(call rpienableconsolecmdline,$(mountdir)/boot/cmdline.txt)

.PHONY: disable_console_cmdline
disable_console_cmdline:
	@$(call rpidisableconsolecmdline,$(mountdir)/boot/cmdline.txt)

.PHONY: enable_console_config
enable_console_config:
	@$(call rpienableconsoleconfig,$(mountdir)/boot/config.txt)

.PHONY: disable_console_config
disable_console_config:
	@$(call rpidisableconsoleconfig,$(mountdir)/boot/config.txt)

.PHONY: enable_force_hdmi_hotplug
enable_force_hdmi_hotplug:
	@$(call rpienableforcehdmihotplug,$(mountdir)/boot/config.txt)

.PHONY: disable_force_hdmi_hotplug
disable_force_hdmi_hotplug: 
	@$(call rpidisableforcehdmihotplug,$(mountdir)/boot/config.txt)

.PHONY: enable_ssh_config
enable_ssh_config:
	@touch $(mountdir)/boot/ssh

.PHONY: checksum_img
checksum_img:
	@cd $(releasedir) && md5sum $(imgname) > $(imgname).md5
	@cd $(releasedir) && sha256sum $(imgname) > $(imgname).sha256
	@cd $(releasedir) && sha1sum $(imgname) > $(imgname).sha1

.PHONY: build_basic_img
build_basic_img: \
	clean_img \
	fetch_img \
	mount_img \
	enable_console_config \
	enable_console_cmdline \
	enable_i2c_config \
	enable_ssh_config \
	disable_force_hdmi_hotplug \
	umount_img 

.PHONY: build_dev_img
build_dev_img: \
	clean_img \
	fetch_img \
	mount_img \
	enable_console_config \
	enable_console_cmdline \
	enable_i2c_config \
	enable_ssh_config \
	disable_force_hdmi_hotplug \
	modules \
	bootclone \
	rootclone \
	umount_img \
	checksum_img

.PHONY: build_img
build_img: \
	clean_img \
	fetch_img \
	mount_img \
	enable_console_config \
	disable_console_cmdline \
	enable_i2c_config \
	enable_ssh_config \
	enable_force_hdmi_hotplug \
	enable_spi_config \
	enable_tpm_config \
	enable_uno220gpio_config \
        enable_TPM_setting \
	modules \
	bootclone \
	rootclone \
	umount_img \
	checksum_img

.PHONY: install_dpkg_img
install_dpkg_img: 
	@cp -a $(currdir)/tools/qemu-arm-static $(mountdir)/root/usr/bin
	@sed -i -e "s/\$${PLATFORM}/v7l/" $(mountdir)/root/etc/ld.so.preload 
	@sed -i -e "/uno-220/d" -e '$$adeb [trusted=yes] https://advantechralph.github.io/uno-220/dpkg/ /' $(mountdir)/root/etc/apt/sources.list
	@RUNLEVEL=1 chroot $(mountdir)/root apt-get update
	@RUNLEVEL=1 chroot $(mountdir)/root apt-get install -y uno220config
	@RUNLEVEL=1 chroot $(mountdir)/root apt-get install -y uno220rtc uno220gpio uno220uart
	@RUNLEVEL=1 chroot $(mountdir)/root apt-get autoclean
	@sed -i -e "s/v7l/\$${PLATFORM}/" $(mountdir)/root/etc/ld.so.preload 
	@rm -rf $(mountdir)/root/usr/bin/qemu-arm-static

define chk_n_mount
  if [ $$(mountpoint -q $(1); echo $$?;) -eq 0 ]; then \
     umount $(1); \
  fi
endef

.PHONY: chroot_start
chroot_start: fetch_img mount_dpkg_img
	@cp -a $(currdir)/tools/qemu-arm-static $(mountdir)/root/usr/bin
	@sed -i -e "s/\$${PLATFORM}/v7l/" $(mountdir)/root/etc/ld.so.preload 
	@$(call chk_n_mount,$(mountdir)/root/dev/pts)
	@$(call chk_n_mount,$(mountdir)/root/dev)
	@$(call chk_n_mount,$(mountdir)/root/proc)
	@$(call chk_n_mount,$(mountdir)/root/sys)
	@mount -o bind /dev $(mountdir)/root/dev
	@mount -o bind /dev/pts $(mountdir)/root/dev/pts
	@mount -t proc proc $(mountdir)/root/proc
	@mount -t sysfs sys $(mountdir)/root/sys
	@RUNLEVEL=1 chroot $(mountdir)/root bash

.PHONY: chroot_stop
chroot_stop: 
	@sed -i -e "s/v7l/\$${PLATFORM}/" $(mountdir)/root/etc/ld.so.preload 
	@rm -rf $(mountdir)/root/usr/bin/qemu-arm-static
	@$(call chk_n_mount,$(mountdir)/root/dev/pts)
	@$(call chk_n_mount,$(mountdir)/root/dev)
	@$(call chk_n_mount,$(mountdir)/root/proc)
	@$(call chk_n_mount,$(mountdir)/root/sys)
	@$(call chk_n_mount,$(mountdir)/root/boot)
	@$(call chk_n_mount,$(mountdir)/root)

.PHONY: build_dpkg_img
build_dpkg_img: \
	clean_img \
	fetch_img \
	mount_dpkg_img \
	install_dpkg_img \
	umount_dpkg_img \
	checksum_img

