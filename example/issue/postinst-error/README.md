
# Demo postinst error


## 原始討論

* [#5 回覆: 更新套件時發生錯誤](https://www.ubuntu-tw.org/modules/newbb/viewtopic.php?post_id=357534#forumpost357534)


## 操作步驟


### 建立專案資料夾

執行下面指令，建立專案資料夾

``` sh
$ mkdir -p demo/DEBIAN
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


### 產生「postinst」檔案

執行下面指令，產生「demo/DEBIAN/postinst」

``` sh
cat > demo/DEBIAN/postinst << EOF
#!/bin/sh

xxxxx

EOF
```

執行下面指令，設定「demo/DEBIAN/postinst」權限

``` sh
$ chmod 775 demo/DEBIAN/postinst
```

註：

測試的時候，也可以執行下面指令，產生「demo/DEBIAN/postinst」

``` sh
cat > demo/DEBIAN/postinst << EOF
#!/bin/sh

exit 10

EOF
```

觀於「postinst」的概念，可以參考「Debian Wiki / MaintainerScripts」。


### 觀看專案資料夾結構

執行下面指令，觀看專案資料夾結構

``` sh
$ tree demo
```

顯示

```
demo
└── DEBIAN
    ├── control
    └── postinst

1 directory, 2 files
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

註:

若是「demo/DEBIAN/postinst」的權限，沒有特別設定，
執行上面的指令，則會出現下面的訊息。

```
dpkg-deb: error: maintainer script 'postinst' has bad permissions 664 (must be >=0555 and <=0775)
```


### 觀看deb檔案資訊

執行下面指令，觀看「demo.deb」的檔案資訊

``` sh
$ dpkg -I demo.deb
```

顯示

```
new debian package, version 2.0.
size 626 bytes: control archive=274 bytes.
	129 bytes,     6 lines      control              
	 18 bytes,     4 lines   *  postinst             #!/bin/sh
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
drwxrwxr-x user/user           0 2017-05-26 10:30 ./
```

## 安裝

執行下面指令，安裝「demo.deb」

``` sh
$ sudo dpkg -i demo.deb
```

顯示

```
...略...
Preparing to unpack demo.deb ...
Unpacking demo (0.1) ...
Setting up demo (0.1) ...
/var/lib/dpkg/info/demo.postinst: 3: /var/lib/dpkg/info/demo.postinst: xxxxx: not found
dpkg: error processing package demo (--install):
 subprocess installed post-installation script returned error exit status 127
Errors were encountered while processing:
 demo
```

執行

``` sh
$ sudo apt-get install
```

顯示

```
...略...
1 not fully installed or removed.
After this operation, 0 B of additional disk space will be used.
Setting up demo (0.1) ...
/var/lib/dpkg/info/demo.postinst: 3: /var/lib/dpkg/info/demo.postinst: xxxxx: not found
dpkg: error processing package demo (--configure):
 subprocess installed post-installation script returned error exit status 127
Errors were encountered while processing:
 demo
E: Sub-process /usr/bin/dpkg returned an error code (1)
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
iF  demo                          0.1                 all                 This is a test package.
```

注意上面開頭是「iF」，

* 「i」指的是「Desired=Install」
* 「F」指的是「Status=halF-conf」


執行

``` sh
$ dpkg -s demo
```

顯示

```
Package: demo
Status: install ok half-configured
Maintainer: developer <developer@home.heaven>
Architecture: all
Version: 0.1
Description: This is a test package.
```

注意上面的「Status:」是「install ok half-configured」

執行

``` sh
$ grep '^Package: demo$' /var/lib/dpkg/status -A 5
```

顯示

```
Package: demo
Status: install ok half-configured
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
Status: install ok half-configured
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
/var/lib/dpkg/info/demo.postinst
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
