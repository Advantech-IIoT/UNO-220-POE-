# How to test UNO-220

- Inset SD card and power on Raspberry Pi 4, and check your DHCP 
  environment for Pi's IP.

- Connect your Pi by ssh. (Default login: pi/raspberry)

  ```
  $ ssh pi@${Pi_IP}    # Pi_IP: Pi's IP address
  ```

- RTC

  Get RTC time

  ```
  pi@raspberrypi:~ $ sudo hwclock -r
  2020-01-13 06:34:43.545566+00:00
  ```

  Set RTC by system time

  ```
  pi@raspberrypi:~ $ sudo hwclock -w
  ```

- GPIO

  Show usage

  ```
  pi@raspberrypi:~ $ sudo uno220gpio -h
  Usage:
    uno220gpio --export=[all|0~7]                  # Export GPIO
    uno220gpio --unexport=[all|0~7]                # Unexport GPIO
    uno220gpio --pin=[0~7] --direction=[in|out]    # Set GPIO Direction
    uno220gpio --pin=[0~7]                         # GPIO Read Operation
    uno220gpio --pin=[0~7] --value=[0|1]           # GPIO Write Operation
    uno220gpio --status
  ```

  Get all GPIO Status

  ```
  pi@raspberrypi:~ $ sudo uno220gpio
   pin       |   0   1   2   3   4   5   6   7
  ---------------------------------------------
   export    |   0   0   0   0   0   0   0   0
   direction |   X   X   X   X   X   X   X   X
   value     |   X   X   X   X   X   X   X   X
  ```

  Export all

  ```
  pi@raspberrypi:~ $ sudo uno220gpio --export=all
  pi@raspberrypi:~ $ sudo uno220gpio
   pin       |   0   1   2   3   4   5   6   7
  ---------------------------------------------
   export    |   1   1   1   1   1   1   1   1
   direction |   I   I   I   I   I   I   I   I
   value     |   1   1   1   1   1   1   1   1
  ```

  Set direction (ex: pin=0, direction=out)

  ```
  pi@raspberrypi:~ $ sudo uno220gpio --pin=0 --direction=out
  pi@raspberrypi:~ $ sudo uno220gpio
   pin       |   0   1   2   3   4   5   6   7
  ---------------------------------------------
   export    |   1   1   1   1   1   1   1   1
   direction |   O   I   I   I   I   I   I   I
   value     |   0   0   1   1   1   1   1   1
  ```

  Set value (ex: pin=0, direction=out, value=1)

  ```
  pi@raspberrypi:~ $ sudo uno220gpio --pin=0 --value=1
  pi@raspberrypi:~ $ sudo uno220gpio
   pin       |   0   1   2   3   4   5   6   7
  ---------------------------------------------
   export    |   1   1   1   1   1   1   1   1
   direction |   O   I   I   I   I   I   I   I
   value     |   1   1   1   1   1   1   1   1
  ```

- Serial port test - PC (Ubuntu 16.04 x86-64) vs Pi 

  Connect your host PC's RS-232 TxD/RxD/GND pins connect to IO Board corresponding pins. 

  - PC send data to Pi 

    Command for Pi: 
 
    ```
    pi@raspberrypi:~ $ sudo uno220uartrecv 
    ```

    Command for host PC:
 
    ```
    $ ./files/host-x86_64/host_send /dev/ttyUSB0 $(echo -ne "\x01\x02\x03")
    ```

    Then, Pi will show received data prompt. 

  - Pi send data to PC  

    Command for host PC:
 
    ```
    $ sudo ./host_recv /dev/ttyUSB0
    ``` 

    Command for Pi: 

    ``` 
    pi@raspberrypi:~ $ sudo uno220uartsend /dev/ttyS0 $(echo -ne "\x01\x02\x03")
    ```

    Then, Pi will show received data prompt. 


