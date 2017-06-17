
# README

For Test Download

## 下載方式

### wget

執行

``` sh
$ wget -c https://raw.githubusercontent.com/samwhelp/demo-about-debian-package/master/download/demo.txt
```

### curl

執行

``` sh
$ curl https://raw.githubusercontent.com/samwhelp/demo-about-debian-package/master/download/demo.txt
```

### apt-helper


執行

``` sh
$ /usr/lib/apt/apt-helper download-file https://raw.githubusercontent.com/samwhelp/demo-about-debian-package/master/download/demo.txt /tmp/demo.txt
```

或是執行

``` sh
/usr/lib/apt/apt-helper download-file https://raw.githubusercontent.com/samwhelp/demo-about-debian-package/master/download/demo.txt /tmp/demo.txt SHA256:0f0af810c640b514ea0cc792ac03611b978928465d9cd43b607d236848969c7f
```

## checksum

### create

``` sh
$ sha256sum demo.txt > SHA256SUMS
```

### check

``` sh
$ sha256sum -c SHA256SUMS
```
