##################################
# folders                        #
##################################
currdir=$(shell pwd)
builddir=$(shell realpath -m $(currdir)/build)
##################################
# dpkg                           #
##################################
#uno220config
dpkgconfigname=uno220config
dpkgconfigversion=0.1
dpkgconfigrevision=2
dpkgconfigarch=arm64
dpkgconfigdesc=Advantech UNO-220 (Raspberry Pi 4) IO Card RTC Package for config.txt and cmdline.txt
dpkgconfigeditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkgconfigdepends=sed (>=4.7-1)
#uno220rtc
dpkgrtcname=uno220rtc
dpkgrtcversion=0.1
dpkgrtcrevision=4
dpkgrtcarch=arm64
dpkgrtcdesc=Advantech UNO-220 (Raspberry Pi 4) IO Card RTC Package for EPSON RTC RX8010
dpkgrtceditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkgrtcdepends=sed (>=4.7-1)
dpkgrtcpredepends=
#uno220gpio
dpkggpioname=uno220gpio
dpkggpioversion=0.1
dpkggpiorevision=2
dpkggpioarch=arm64
dpkggpiodesc=Advantech UNO-220 (Raspberry PI 4) IO Card GPIO EXPANDER for TI TCA9554 
dpkggpioeditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkggpiodepends=sed (>=4.7-1)
#uno220uart
dpkguartname=uno220uart
dpkguartversion=0.1
dpkguartrevision=2
dpkguartarch=arm64
dpkguartdesc=Advantech UNO-220 (Raspberry PI 4) UART Tools
dpkguarteditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkguartdepends=sed (>=4.7-1)
#uno220test
dpkgtestname=uno220test
dpkgtestversion=0.1
dpkgtestrevision=2
dpkgtestarch=arm64
dpkgtestdesc=Advantech UNO-220 (Raspberry Pi 4) IO Card RTC Package for EPSON RTC RX8010
dpkgtesteditor=Ralph Wang <ralph.wang@advantech.com.tw>
dpkgtestdepends=sed (>=4.7-1)
dpkgtestpredepends=
