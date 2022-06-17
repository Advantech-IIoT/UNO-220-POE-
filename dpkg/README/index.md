
# UNO-220 Debian Packages for Serial, GPIO and RTC. 

## Introduction
- Current version: 
    - uno220config: 0.1-2
    - uno220cputempmon: 0.1-1
    - uno220gpio: 0.1-3
    - uno220gpiopins: 0.1-1
    - uno220rtc: 0.1-5
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
  - [raspios_full_armhf-2021-05-28](http://downloads.raspberrypi.org/raspios_full_armhf/images/raspios_full_armhf-2021-05-28/)


## Chagelog

- 2021-07-06
    - normal version (synchronized): 
        - Update supported image to 2021-05-28. 

- 2021-01-13
    - beta version and normal version (synchronized): 
        - GPIO 12 LED disabled when system ready. 
        - Update supported image to 2020-12-04. 
- 2021-01-05
    - beta version: 
        - CPU temperature monitor sample code package.
        - TPM device tree overlay package. 

## How to Install UNO-220 Packages

Download driver package which is deb format to your Pi 4. 

Install driver package to your Pi 4. 

```
$ sudo dpkg -i uno220config_0.1-2_armhf.deb
$ sudo dpkg -i uno220gpio_0.1-3_armhf.deb
$ sudo dpkg -i uno220rtc_0.1-5_armhf.deb
$ sudo dpkg -i uno220uart_0.1-3_armhf.deb
```

GPIO Pin Definition Packages

```
$ sudo dpkg -i uno220gpiopins_0.1-1_armhf.deb
```

Optional packages
```
$ sudo dpkg -i uno220cputempmon_0.1-1_armhf.deb
$ sudo dpkg -i uno220tpm_0.1-1_armhf.deb
```

Reboot your Pi 4 and test IO. 

```
$ sudo systemctl reboot
```

###### tags: `uno220`, `raspberrypi`
