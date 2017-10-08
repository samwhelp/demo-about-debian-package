
# 如何製作「Debian Package」/ 基本


## 操作步驟


### 建立專案資料夾

執行下面指令，建立專案資料夾

``` sh
mkdir -p demo/DEBIAN
mkdir -p demo/usr/bin
mkdir -p demo/usr/share/package-data-downloads
```


### 產生「control」檔案

執行下面指令，產生「demo/DEBIAN/control」

``` sh
cat > demo/DEBIAN/control << EOF
Package: demo
Version: 0.1
Architecture: all
Description: This is a test package.
Maintainer: developer <developer@home.heaven>

EOF
```

可以執行「$ `man deb-control`」來閱讀「欄位說明」。


### 產生「demo/usr/bin/demo」

執行下面指令，產生「demo/usr/bin/demo」

``` sh
cat > demo/usr/bin/demo << EOF
#!/usr/bin/env bash

echo '================================================='
echo '# Test package-data-downloads'
echo

cp /var/lib/update-notifier/package-data-downloads/partial/demo.txt /tmp/demo.txt

echo 'copy'
echo '	/var/lib/update-notifier/package-data-downloads/partial/demo.txt'
echo 'to'
echo '	/tmp/demo.txt'
echo
echo '================================================='
echo
echo '$ cat /tmp/demo.txt'
echo
echo '-------------------------------------------------'

cat /tmp/demo.txt

echo '-------------------------------------------------'
echo '================================================='

EOF
```

執行下面指令，設定執行權限

``` sh
$ chmod +x demo/usr/bin/demo
```

執行

``` sh
$ demo/usr/bin/demo
```

### 產生「demo/usr/share/package-data-downloads/demo」

執行下面指令，產生「demo/usr/share/package-data-downloads/demo」

``` sh
cat > demo/usr/share/package-data-downloads/demo << EOF

Url: https://raw.githubusercontent.com/samwhelp/demo-about-debian-package/master/download/demo.txt
Sha256: 0f0af810c640b514ea0cc792ac03611b978928465d9cd43b607d236848969c7f

Script: /usr/bin/demo

EOF
```


### 觀看專案資料夾結構

執行下面指令，觀看專案資料夾結構

``` sh
$ tree demo
```

顯示

```
demo
├── DEBIAN
│   └── control
└── usr
    ├── bin
    │   └── demo
    └── share
        └── package-data-downloads
            └── demo

5 directories, 3 files
```


### 打包成「Debian Package」

執行下面指令，將「demo」打包成「deb檔」。

``` sh
$ dpkg -b demo
```

顯示

```
dpkg-deb: building package 'demo' in 'demo.deb'.
```

會產生一個檔案「demo.deb」。


### 觀看deb檔案資訊

執行下面指令，觀看「demo.deb」的檔案資訊

``` sh
$ dpkg -I demo.deb
```

顯示

```
new debian package, version 2.0.
size 994 bytes: control archive=241 bytes.
	129 bytes,     6 lines      control              
Package: demo
Version: 0.1
Architecture: all
Description: This is a test package.
Maintainer: developer <developer@home.heaven>
```

執行

``` sh
$ dpkg -f demo.deb
```

顯示

```
Package: demo
Version: 0.1
Architecture: all
Description: This is a test package.
Maintainer: developer <developer@home.heaven>
```

執行

``` sh
$ dpkg -c demo.deb
```

顯示

```
drwxrwxr-x user/user           0 2017-06-17 15:25 ./
drwxrwxr-x user/user           0 2017-06-17 15:26 ./usr/
drwxrwxr-x user/user           0 2017-06-17 15:25 ./usr/bin/
-rwxrwxr-x user/user         612 2017-06-17 16:24 ./usr/bin/demo
drwxrwxr-x user/user           0 2017-06-17 15:26 ./usr/share/
drwxrwxr-x user/user           0 2017-06-17 15:26 ./usr/share/package-data-downloads/
-rw-rw-r-- user/user         197 2017-06-17 16:24 ./usr/share/package-data-downloads/demo
```


## 安裝

執行下面指令，安裝「demo.deb」

``` sh
$ sudo dpkg -i demo.deb
```


## 確認是否安裝

執行

``` sh
$ dpkg -l demo
```

顯示

```
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                          Version             Architecture        Description
+++-=============================-===================-===================-================================================================
ii  demo                          0.1                 all                 This is a test package.
```

執行

``` sh
$ dpkg -s demo
```

顯示

```
Package: demo
Status: install ok installed
Maintainer: developer <developer@home.heaven>
Architecture: all
Version: 0.1
Description: This is a test package.
```

執行

``` sh
$ grep '^Package: demo$' /var/lib/dpkg/status -A 5
```

顯示

```
Package: demo
Status: install ok installed
Maintainer: developer <developer@home.heaven>
Architecture: all
Version: 0.1
Description: This is a test package.
```

執行

``` sh
$ apt-cache show demo
```

顯示

```
Package: demo
Status: install ok installed
Maintainer: developer <developer@home.heaven>
Architecture: all
Version: 0.1
Description: This is a test package.
Description-md5: 9aba808511e384454d68cb7face0f2da
```

執行

``` sh
$ ls /var/lib/dpkg/info/demo* -1
```

顯示

```
/var/lib/dpkg/info/demo.list
/var/lib/dpkg/info/demo.md5sums
```


### 觀看那些檔案安裝在系統上

執行

``` sh
$ dpkg -L demo
```

顯示

```
/.
/usr
/usr/bin
/usr/bin/demo
/usr/share
/usr/share/package-data-downloads
/usr/share/package-data-downloads/demo
```

執行

``` sh
$ cat /var/lib/dpkg/info/demo.list
```

顯示

```
/.
/usr
/usr/bin
/usr/bin/demo
/usr/share
/usr/share/package-data-downloads
/usr/share/package-data-downloads/demo
```

執行

``` sh
$ cat /var/lib/dpkg/info/demo.md5sums
```

顯示

```
c2d44273111e3372f68645f8a4e8b577  usr/bin/demo
592b9510c84031e0fba05516623c66a0  usr/share/package-data-downloads/demo
```


### 移除

執行下面指令，透過「dpkg」，移除「demo」這個「Package」

``` sh
$ sudo dpkg -r demo
```

或是執行下面指令，透過「apt-get」，移除「demo」這個「Package」

``` sh
$ sudo apt-get remove demo
```


## 相關討論

* [url=https://www.ubuntu-tw.org/modules/newbb/viewtopic.php?post_id=357678#forumpost357678]#5 回覆: 每次開機都跳出「下載額外資料檔案失敗 flashplugin-installer」[/url]
