#!/bin/bash

mount -oremount,rw /
modprobe -r tpm_tis_spi
mount -oremount,ro /
