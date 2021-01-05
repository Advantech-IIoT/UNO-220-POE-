
# SD Card (mmc0) Activity LED control 

---
## /boot/config.txt

Change activity LED to gpio 12 and active low. 

```shell=
dtoverlay=act-led,gpio=12,activelow=on
```
---
###### tags: `uno220` `raspberrypi`