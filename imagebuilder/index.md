
# Build SD Card Image for Raspberry Pi 4 with UNO-220

## Introduction

The image builder is a makefile architecture for generating Advantech released image 
for UNO-220 IO on Raspberry Pi 4. 

## Prerequisite

- [Raspberry pi 4 model b](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/)
- [Image Builder from Github]()
- Advantech UNO-220 (IO extender)
- SD card (over 8GB recommanded)
- Host PC (Ubuntu 18.04 x86_64 recommanded or Ubuntu 20.04 x86_64)
  - Packages needs to be installed in host Ubuntu.
    ```
    $ apt-get update
    $ apt-get install -y net-tools bison ssh git make curl gcc build-essential gcc-arm-linux-gnueabief flex libssl-lib
    ```
  - In Ubuntu 20.04, if there is error: /usr/bin/env: 'python': No such file or directory, please install python3 and set the shortcut.
    ```
    $ whereis python3
    $ sudo ln -s /usr/bin/python3 /usr/bin/python
    ```


## Clone 32-bit Builder Source

- ssh
  ```
  $ git clone git@github.com:Advantech-IIoT/UNO-220-POE-.git
  ```
- https
  ```
  $ git clone https://github.com/Advantech-IIoT/UNO-220-POE-.git
  ```

## Clone 64-bit Builder Source

- ssh
  ```
  $ git clone -b master_arm64 git@github.com:Advantech-IIoT/UNO-220-POE-.git
  ```
- https
  ```
  $ git clone -b master_arm64 https://github.com/Advantech-IIoT/UNO-220-POE-.git

## Build Commands

- Change the image type and image version.

  ```
  $ vi macro.mk
  ```
  Input the imgver and imgtype (lite, desktop or full) according to the requirement, then save the file. 


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

###### tags: `uno220`, `raspberrypi`
