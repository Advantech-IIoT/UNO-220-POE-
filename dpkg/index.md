# UNO-220 Debian Packages Builder

## Quick Start

```shell=
$ git clone https://github.com/advantechralph/uno-220.git
$ cd uno-220
$ make dpkg
$ ls build/dpkg/*.deb
build/dpkg/uno220config_0.1-2_armhf.deb build/dpkg/uno220gpio_0.1-2_armhf.deb  build/dpkg/uno220rtc_0.1-2_armhf.deb  build/dpkg/uno220uart_0.1-2_armhf.deb
```

The version of packages depends on the image builder version. 

## Install packages

Before install uno-220 packages, please enable ssh on the Raspberry Pi 4 for convinient. 
Then, upload deb files up to Raspberry Pi 4 and install packages by commands as below. 

```
pi@raspberrypi:~$ sudo dpkg -i uno220config_0.1-2_armhf.deb
pi@raspberrypi:~$ sudo dpkg -i uno220rtc_0.1-2_armhf.deb
pi@raspberrypi:~$ sudo dpkg -i uno220gpio_0.1-2_armhf.deb
pi@raspberrypi:~$ sudo dpkg -i uno220uart_0.1-2_armhf.deb
```
After installation is done, please reboot your Pi. 

## Generate Packages and Packages.gz commands

```
$ dpkg-scanpackages . /dev/null  | gzip -9c > Packages.gz
$ dpkg-scanpackages . /dev/null  > Packages
```

