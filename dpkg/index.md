# UNO-220 Debian Packages

## Create Packages and Packages.gz

```
$ dpkg-scanpackages . /dev/null  | gzip -9c > Packages.gz
$ dpkg-scanpackages . /dev/null  > Packages
```

