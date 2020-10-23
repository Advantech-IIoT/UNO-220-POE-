
# UNO-220 

---

## Introduction

- An IO extension for Raspberry Pi 4. 
- Designed by Advantech Corp.

---

## Abouut Raspberry Pi 4

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
    
  - Write image to SD card

    ```
    $ make write_sd
    ```
    
    Then, follow the prompt to write image to SD card. 

---

