
# UNO-220 Debian Packages for Serial, GPIO and RTC. 

## Introduction

- Current version: 0.1-2
- Supported image: 
  - [raspbian_full-2019-09-30](http://downloads.raspberrypi.org/raspbian_full/images/raspbian_full-2019-09-30/)
  - [raspbian_full-2020-02-07](http://downloads.raspberrypi.org/raspbian_full/images/raspbian_full-2020-02-07/)
  - [raspbian_full-2020-02-14](http://downloads.raspberrypi.org/raspbian_full/images/raspbian_full-2020-02-14/)
  - [raspios_full_armhf-2020-05-28](http://downloads.raspberrypi.org/raspios_full_armhf/images/raspios_full_armhf-2020-05-28/)
  - [raspios_full_armhf-2020-08-24](http://downloads.raspberrypi.org/raspios_full_armhf/images/raspios_full_armhf-2020-08-24/)

## How to Install UNO-220 Packages

Append the following in `/etc/apt/sources.list` on your Pi 4. 


```
deb [trusted=yes] https://advantechralph.github.io/uno-220/dpkg/ /
```

For Ubuntu 20.04 arm64: 

```
deb [trusted=yes] https://advantechralph.github.io/uno-220/dpkg/arm64/ /
```

Run `apt-get update`

```
$ sudo apt-get update
```

Install packages. 

```
$ sudo apt-get install uno220config uno220rtc uno220gpio uno220uart
```

Reboot your Pi 4 and test IO. 

```
$ sudo systemctl reboot
```

###### tags: `uno220`, `raspberrypi`
