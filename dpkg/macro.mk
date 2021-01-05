##################################
# folders                        #
##################################
currdir=$(shell pwd)
builddir=$(shell realpath -m $(currdir)/build)
##################################
# dpkg                           #
##################################
dpkgs=config rtc gpio uart tpm cputempmon
dpkgconfigname=uno220config
dpkgconfigversion=0.1
dpkgconfigrevision=2
dpkgconfigarch=armhf
dpkgconfigdesc=Advantech UNO-220 (Raspberry Pi 4) IO Card RTC Package for config.txt and cmdline.txt
dpkgconfigeditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkgconfigdepends=sed (>=4.7-1)
dpkgrtcname=uno220rtc
dpkgrtcversion=0.1
dpkgrtcrevision=2
dpkgrtcarch=armhf
dpkgrtcdesc=Advantech UNO-220 (Raspberry Pi 4) IO Card RTC Package for EPSON RTC RX8010
dpkgrtceditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkgrtcdepends=sed (>=4.7-1)
dpkgrtcpredepends=raspberrypi-kernel (<=1.20201022-1)
dpkggpioname=uno220gpio
dpkggpioversion=0.1
dpkggpiorevision=2
dpkggpioarch=armhf
dpkggpiodesc=Advantech UNO-220 (Raspberry PI 4) IO Card GPIO EXPANDER for TI TCA9554 
dpkggpioeditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkggpiodepends=sed (>=4.7-1)
dpkguartname=uno220uart
dpkguartversion=0.1
dpkguartrevision=2
dpkguartarch=armhf
dpkguartdesc=Advantech UNO-220 (Raspberry PI 4) UART Tools
dpkguarteditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkguartdepends=sed (>=4.7-1)
dpkgtpmname=uno220tpm
dpkgtpmversion=0.1
dpkgtpmrevision=1
dpkgtpmarch=armhf
dpkgtpmdesc=Advantech UNO-220 (Raspberry Pi 4) IO Card TPM Package
dpkgtpmeditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkgtpmdepends=sed (>=4.7-1)
dpkgcputempmonname=uno220cputempmon
dpkgcputempmonversion=0.1
dpkgcputempmonrevision=1
dpkgcputempmonarch=armhf
dpkgcputempmondesc=Advantech UNO-220 (Raspberry Pi 4) IO Card CPU Temperature Monitor Sample Code Package
dpkgcputempmoneditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkgcputempmondepends=sed (>=4.7-1)
