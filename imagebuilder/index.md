
# Build SD Card Image for Raspberry Pi 4 with UNO-220

## Introduction

The image builder is a makefile architecture for generating Advantech released image 
for UNO-220 IO on Raspberry Pi 4. 

## Prerequisite

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

## Clone Builder Source

- ssh
  ```
  $ git clone git@github.com:advantechralph/uno-220.git
  ```
- https
  ```
  $ git clone https://github.com/advantechralph/uno-220.git
  ```

## Build Commands

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