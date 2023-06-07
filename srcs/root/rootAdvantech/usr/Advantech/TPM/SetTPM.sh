#!/bin/bash

sudo mv /usr/Advantech/TPM/TPM.service /etc/systemd/system/TPM.service
sudo systemctl start TPM --now
sudo systemctl enable TPM
if [ -f "/usr/Advantech/TPM/uno220rtc_0.1-7_armhf.deb" ]; then
	sudo dpkg -i /usr/Advantech/TPM/uno220rtc_0.1-7_armhf.deb
	sudo sync
	sudo rm -f /usr/Advantech/TPM/uno220rtc_0.1-7_armhf.deb
fi
