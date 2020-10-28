# UNO-220 Debian Packages

## Generate Packages and Packages.gz commands

```
$ dpkg-scanpackages . /dev/null  | gzip -9c > Packages.gz
$ dpkg-scanpackages . /dev/null  > Packages
```

