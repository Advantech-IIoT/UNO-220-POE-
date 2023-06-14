#!/bin/bash

if [ -e /usr/Advantech/RTC/uno220rtc_0.1-4_arm64.deb ]
then
	sudo dpkg -i /usr/Advantech/RTC/uno220rtc_0.1-4_arm64.deb
	sudo sleep 3
	sudo rm /usr/Advantech/RTC/uno220rtc_0.1-4_arm64.deb

else
	sudo sed -i '/SetRTC/d' /etc/rc.local
	sudo rm -r /usr/Advantech/RTC
	sudo rm -r /usr/Advantech/rtc
	#Empty the trash can.
  	sudo rm -r /media/user/CC9E5D959E5D78C2/.Trash-1000/files/*   
fi
