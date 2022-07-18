#!/bin/bash

if [ -e /usr/Advantech/TPM/TPM.service ]
then
        sudo mv /usr/Advantech/TPM/TPM.service /etc/systemd/system/TPM.service
	sudo systemctl start TPM --now
	sudo systemctl enable TPM

else
        sudo sed -i '/SetTPM/d' /etc/rc.local
        sudo rm -r /usr/Advantech/RTC
fi




