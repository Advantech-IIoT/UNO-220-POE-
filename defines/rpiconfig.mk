# config.txt: i2c
define rpienablei2cconfig
  ( \
    sed -i -e '/dtparam=i2c_arm=on/s/^[\t #]*//' $1; \
  )
endef
define rpidisablei2cconfig
  ( \
    sed -i -e '/dtparam=i2c_arm=on/s/^/#/' $1; \
  )
endef
# cmdline.txt: console 
define rpidisableconsolecmdline
  ( sed -i -e "s/console=[^ ]*//g" -e "s/^ *//" $(1) )
endef
define rpienableconsolecmdline
  ( sed -i -e "s/console=[^ ]*//g" -e "s/^ *//" -e "s/^/console=serial0,115200 console=tty1 /g" -e "s/^ *//" $(1) )
endef
define rpidisableconsoleconfig
  ( sed -i -e '/enable_uart=1/d' $(1) )
endef
# config.txt: uart
define rpienableconsoleconfig
  ( sed -i -e '/enable_uart=1/d' -e '/\[all\]/aenable_uart=1' $(1) )
endef
define rpidisableforcehdmihotplug
  ( sed -i -e 's/.*hdmi_force_hotplug=.*/#hdmi_force_hotplug=1/' $(1) )
endef
# config.txt: hdmi
define rpienableforcehdmihotplug
  ( sed -i -e 's/.*hdmi_force_hotplug=.*/hdmi_force_hotplug=1/' $(1) )
endef
define rpienablespiconfig
  ( \
    sed -i -e '/dtparam=spi=on/s/^[\t #]*//' $1; \
  )
endef
# config.txt: spi
define rpidisablespiconfig
  ( \
    sed -i -e '/dtparam=spi=on/s/^/#/' $1; \
  )
endef
# config.txt: tpm-slb9670
define rpidisabletpmconfig
  ( sed -i -e '/dtoverlay=tpm-slb9670/d' $(1) )
endef
define rpienabletpmconfig
  ( sed -i -e '/dtoverlay=tpm-slb9670/d' -e '/\[all\]/adtoverlay=tpm-slb9670' $(1) )
endef
# rc.local: tpm-slb9670
define enableTPMsetting
  ( sed -i -e '/By default this script does nothing./a\/usr\/Advantech\/TPM\/SetTPM\.sh' $(1)  )
endef
# rc.local: rtc
define InstallRTCpackage
  ( sed -i -e '/By default this script does nothing./a\/usr\/Advantech\/RTC\/SetRTC\.sh' $(1) )
endef
# config.txt: uno220-gpio
define rpidisableuno220gpioconfig
  ( sed -i -e '/dtoverlay=uno220-gpio/d' $(1) )
endef
define rpienableuno220gpioconfig
  ( sed -i -e '/dtoverlay=uno220-gpio/d' -e '/\[all\]/adtoverlay=uno220-gpio' $(1) )
endef
