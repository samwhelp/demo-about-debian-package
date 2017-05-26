
# 如何製作「Debian Package」/ 起步


## 操作步驟


### 建立專案資料夾

執行下面指令，建立專案資料夾

``` sh
$ mkdir -p demo/DEBIAN
```


### 產生「control」檔案

執行下面指令，產生「demo/DEBIAN/control」

```
cat > demo/DEBIAN/control << EOF
Package: demo
Version: 0.1
Architecture: all
Description: This is a test package.
Maintainer: developer <developer@home.heaven>

EOF
```

可以執行「$ `man deb-control`」來閱讀「欄位說明」。


### 觀看專案資料夾結構

執行下面指令，觀看專案資料夾結構

``` sh
$ tree demo
```

顯示

```
demo
└── DEBIAN
    └── control
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
size 592 bytes: control archive=239 bytes.
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
drwxrwxr-x user/user           0 2017-05-26 10:30 ./
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
```

執行

``` sh
$ cat /var/lib/dpkg/info/demo.list
```

顯示

```
/.
```

執行

``` sh
$ cat /var/lib/dpkg/info/demo.md5sums
```

沒有任何顯示，直接跳下一個提示字元。


### 移除

執行下面指令，透過「dpkg」，移除「demo」這個「Package」

``` sh
$ sudo dpkg -r demo
```

或是執行下面指令，透過「apt-get」，移除「demo」這個「Package」

``` sh
$ sudo apt-get remove demo
```


### 強制移除

執行下面指令，觀看「force」選項說明

``` sh
$ dpkg --force-help
```

顯示

```
dpkg forcing options - control behaviour when problems found:
  warn but continue:  --force-<thing>,<thing>,...
  stop with error:    --refuse-<thing>,<thing>,... | --no-force-<thing>,...
 Forcing things:
  [!] all                Set all force options
  [*] downgrade          Replace a package with a lower version
      configure-any      Configure any package which may help this one
      hold               Process incidental packages even when on hold
      not-root           Try to (de)install things even when not root
      bad-path           PATH is missing important programs, problems likely
      bad-verify         Install a package even if it fails authenticity check
      bad-version        Process even packages with wrong versions
      overwrite          Overwrite a file from one package with another
      overwrite-diverted Overwrite a diverted file with an undiverted version
  [!] overwrite-dir      Overwrite one package's directory with another's file
  [!] unsafe-io          Do not perform safe I/O operations when unpacking
  [!] confnew            Always use the new config files, don't prompt
  [!] confold            Always use the old config files, don't prompt
  [!] confdef            Use the default option for new config files if one
                         is available, don't prompt. If no default can be found,
                         you will be prompted unless one of the confold or
                         confnew options is also given
  [!] confmiss           Always install missing config files
  [!] confask            Offer to replace config files with no new versions
  [!] architecture       Process even packages with wrong or no architecture
  [!] breaks             Install even if it would break another package
  [!] conflicts          Allow installation of conflicting packages
  [!] depends            Turn all dependency problems into warnings
  [!] depends-version    Turn dependency version problems into warnings
  [!] remove-reinstreq   Remove packages which require installation
  [!] remove-essential   Remove an essential package

WARNING - use of options marked [!] can seriously damage your installation.
Forcing options marked [*] are enabled by default.
```

執行下面指令，強制移除

``` sh
$ sudo dpkg -r --force-all demo
```

或是執行下面指令，強制移除，忽略相依性的問題

``` sh
$ sudo dpkg -r --force-depends demo
```

強制移除相關討論：「[#23 回覆: 套件系統損壞 （懷疑是 LiberOffice 與 OpenOffice 衝突）](https://www.ubuntu-tw.org/modules/newbb/viewtopic.php?post_id=339622#forumpost339622)」


## 相關討論

* [如何製作「deb檔(Debian Package)」](http://samwhelp.github.io/book-ubuntu-basic-skill/book/content/package/how-to-build-package.html)
* [[影片教學][TOSSUG] Debian 套件打包工作坊](https://www.ubuntu-tw.org/modules/newbb/viewtopic.php?post_id=339076#forumpost339076)
* [[索引] 套件操作實務](https://www.ubuntu-tw.org/modules/newbb/viewtopic.php?post_id=333562#forumpost333562)


## Manpage

* $ man [deb-control](http://manpages.ubuntu.com/manpages/xenial/en/man5/deb-control.5.html)
* $ man [deb-old](http://manpages.ubuntu.com/manpages/xenial/en/man5/deb-old.5.html)
* $ man [deb](http://manpages.ubuntu.com/manpages/xenial/en/man5/deb.5.html)
* $ man [dpkg-deb](http://manpages.ubuntu.com/manpages/xenial/en/man1/dpkg-deb.1.html)
* $ man [dpkg-query](http://manpages.ubuntu.com/manpages/xenial/en/man1/dpkg-query.1.html)
* $ man [dpkg](http://manpages.ubuntu.com/manpages/xenial/en/man1/dpkg.1.html)
* $ man [apt-get](http://manpages.ubuntu.com/manpages/xenial/en/man8/apt-get.8.html)
* $ man [apt-cache](http://manpages.ubuntu.com/manpages/xenial/en/man8/apt-cache.8.html)
* $ man [apt](http://manpages.ubuntu.com/manpages/xenial/en/man8/apt.8.html)
