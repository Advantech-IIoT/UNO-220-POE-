
# UNO-220 Debian Packages for Serial, GPIO and RTC. 

## Introduction
- Current version: 
    - uno220config: 0.1-2
    - uno220cputempmon: 0.1-1
    - uno220gpio: 0.1-3
    - uno220gpiopins: 0.1-1
    - uno220rtc: 0.1-4
    - uno220tpm: 0.1-1
    - uno220uart: 0.1-3
- Supported image: 
  - [raspbian_full-2019-09-30](http://downloads.raspberrypi.org/raspbian_full/images/raspbian_full-2019-09-30/)
  - [raspbian_full-2020-02-07](http://downloads.raspberrypi.org/raspbian_full/images/raspbian_full-2020-02-07/)
  - [raspbian_full-2020-02-14](http://downloads.raspberrypi.org/raspbian_full/images/raspbian_full-2020-02-14/)
  - [raspios_full_armhf-2020-05-28](http://downloads.raspberrypi.org/raspios_full_armhf/images/raspios_full_armhf-2020-05-28/)
  - [raspios_full_armhf-2020-08-24](http://downloads.raspberrypi.org/raspios_full_armhf/images/raspios_full_armhf-2020-08-24/)
  - [raspios_full_armhf-2020-12-04](http://downloads.raspberrypi.org/raspios_full_armhf/images/raspios_full_armhf-2020-12-04/)
  - [raspios_full_armhf-2021-01-12](http://downloads.raspberrypi.org/raspios_full_armhf/images/raspios_full_armhf-2021-01-12/)


## Chagelog

- 2021-01-13
    - beta version and normal version (synchronized): 
        - GPIO 12 LED disabled when system ready. 
        - Update supported image to 2020-12-04. 
- 2021-01-05
    - beta version: 
        - CPU temperature monitor sample code package.
        - TPM device tree overlay package. 

## How to Install UNO-220 Packages

Append the following in `/etc/apt/sources.list` on your Pi 4. 

```
deb [trusted=yes] https://advantechralph.github.io/uno-220/dpkg/ /
```

For beta testing packages
```
deb [trusted=yes] https://advantechralph.github.io/uno-220/dpkg/beta/ /
```

Run `apt-get update`

```
$ sudo apt-get update
```

Install packages. 

```
$ sudo apt-get install uno220config uno220rtc uno220gpio uno220uart
```

GPIO Pin Definition Packages

```
$ sudo apt-get install uno220gpiopins
```

Optional packages
```
$ sudo apt-get install uno220tpm uno220cputempmon
```

Reboot your Pi 4 and test IO. 

```
$ sudo systemctl reboot
```

###### tags: `uno220`, `raspberrypi`