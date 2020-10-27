
# UNO-220 

---

## Introduction

- An IO extension for Raspberry Pi 4. 
- Designed by Advantech Corp.

---

## About Raspberry Pi 4

- [Raspberry Pi 4 model b](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/) 
- [40 pins GPIO](https://www.raspberrypi.org/documentation/usage/gpio/)
- [BCM2711 ARM Peripherals (CPU)](https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711/rpi_DATA_2711_1p0.pdf)
- [Raspberry Pi 4 Model B Datasheet](https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711/rpi_DATA_2711_1p0_preliminary.pdf)
- [UART Configuration](https://www.raspberrypi.org/documentation/configuration/uart.md)
- Offical Images Download
  - [Raspbian Full](http://downloads.raspberrypi.org/raspbian_full/images/)
  - [Raspios Full (After 2020/05)](http://downloads.raspberrypi.org/raspios_full_armhf/images/)

---

## About UNO-220

- TI TCA9554 IO extender
- RTC RX-8010SJ-B
- Serial to RS-232/485
- Raspberry Pi 4 image base: 2020-08-20-raspios-buster-armhf-full.img

---

## Build SD Card Image for Raspberry Pi 4 with UNO-220

- ### Prerequisite

  - [Raspberry pi 4 model b](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/)
  - [Image Builder from Github]()
  - Advantech UNO-220 (IO extender)
  - SD card (over 8GB recommanded)
  - Host PC
    - Ubuntu 18.04 x86_64 (recommanded)
    - Packages needs to be installed in host Ubuntu.
      ```
      $ apt-get install -y bison flex libssl-dev
      ```

- ### Build Image

  - #### Clone Builder Source

    ssh
    ```
    $ git clone git@github.com:advantechralph/uno-220.git
    ```
    https
    ```
    $ git clone https://github.com/advantechralph/uno-220.git
    ```

  - #### Build Commands
  
    - Show builder usage
  
      ```
      $ make help
      ```
  
    - Build image
      ```
      $ make build_img
      ```
    - Image information
      
      After building image done, you can use the command as below to
      show the information of the image. 
  
      ```
      $ make info
      ```
      
    - Write image to SD card
  
      ```
      $ make write_sd
      ```
      
      Then, follow the prompt to write image to SD card. 

---

## Build UNO-220 Debian packages for the official Raspberry Pi Images

- ### Build Packages

  - #### Clone Builder Source

    ssh
    ```
    $ git clone git@github.com:advantechralph/uno-220.git
    ```
    https
    ```
    $ git clone https://github.com/advantechralph/uno-220.git
    ```

  - #### Build packages command

    ```
    $ make dpkg
    $ ls build/dpkg/*.deb
    build/dpkg/uno220gpio_0.1-2_armhf.deb  build/dpkg/uno220rtc_0.1-2_armhf.deb  build/dpkg/uno220uart_0.1-2_armhf.deb
    ```

    The version of packages depends on the image builder version. 

  - #### Install packages

    Before install uno-220 packages, please enable ssh and console for the Raspberry Pi 4. 
    Then, upload deb files up to Raspberry Pi 4 and install packages by commands as below. 

    Install rtc package first, and it will install driver module and enable i2c in the
    '/boot/config.txt'. 
    
    ```
    pi@raspberrypi:~$ sudo dpkg -i uno220rtc_0.1-2_armhf.deb
    ```

    After install rtc package, please reboot yout Pi for enabling i2c.  
    After Pi boot up, install the rest of packages for gpio and serial. 

    ```
    pi@raspberrypi:~$ sudo dpkg -i uno220gpio_0.1-2_armhf.deb
    pi@raspberrypi:~$ sudo dpkg -i uno220uart_0.1-2_armhf.deb
    ```





