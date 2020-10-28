# UNO-220 Debian Packages for Serial, GPIO and RTC. 

Append the following in `/etc/apt/sources.list` on your Pi 4. 

```
deb [trusted=yes] https://advantechralph.github.io/uno-220/dpkg/ /
```

Run `apt-get update`

```
$ sudo apt-get update
```

Install packages. 

```
$ sudo apt-get install uno220config uno220rtc uno220gpio uno220uart
```

Reboot your Pi 4 and test IO. 

```
$ sudo systemctl reboot
```

