#!/bin/bash

sudo mv /usr/Advantech/TPM/TPM.service /etc/systemd/system/TPM.service
sudo systemctl start TPM --now
sudo systemctl enable TPM
