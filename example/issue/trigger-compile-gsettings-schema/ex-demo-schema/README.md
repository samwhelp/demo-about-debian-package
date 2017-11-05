
# trigger-compile-gsettings-schema / demo-schema


## 建立「demo-schema」

``` sh
$ make create
```

執行

``` sh
$ tree demo-schema
```

顯示

```
demo-schema/
├── DEBIAN
│   └── control
└── usr
    └── share
        └── glib-2.0
            └── schemas
                └── org.test.demo.gschema.xml

5 directories, 2 files
```


## 建立「demo-schema.deb」

執行

``` sh
$ make build
```

顯示

```
dpkg-deb: building package 'demo-schema' in 'demo-schema.deb'.
```

就會產生「demo-schema.deb」這個檔案。


## 先行確認系統目前的「schemas」

執行

``` sh
$ grep 'to-be-or-not-to-be' /usr/share/glib-2.0/schemas/* -R
```

沒有任何顯示，直接出現另一個提示字元。


## 觀看「demo.deb」的「content」

執行

``` sh
$ dpkg -c demo-schema.deb
```

顯示

```
drwxr-xr-x user/user           0 2017-11-05 14:25 ./
drwxr-xr-x user/user           0 2017-11-05 14:25 ./usr/
drwxr-xr-x user/user           0 2017-11-05 14:25 ./usr/share/
drwxr-xr-x user/user           0 2017-11-05 14:25 ./usr/share/glib-2.0/
drwxr-xr-x user/user           0 2017-11-05 14:25 ./usr/share/glib-2.0/schemas/
-rw-r--r-- user/user         285 2017-11-05 14:25 ./usr/share/glib-2.0/schemas/org.test.demo.gschema.xml
```


## 安裝「demo-schema.deb」

執行

``` sh
$ sudo dpkg -i demo-schema.deb
```

顯示

```
Selecting previously unselected package demo-schema.
(Reading database ... 185696 files and directories currently installed.)
Preparing to unpack demo-schema.deb ...
Unpacking demo-schema (0.1) ...
Setting up demo-schema (0.1) ...
Processing triggers for libglib2.0-0:amd64 (2.54.1-1ubuntu1) ...
```

## 觀看那些檔案安裝到系統

執行

``` sh
$ dpkg -L demo-schema
```

顯示

```
/.
/usr
/usr/share
/usr/share/glib-2.0
/usr/share/glib-2.0/schemas
/usr/share/glib-2.0/schemas/org.test.demo.gschema.xml
```


## 觀看「/usr/share/glib-2.0/schemas/org.test.demo.gschema.xml」

執行

``` sh
$ cat /usr/share/glib-2.0/schemas/org.test.demo.gschema.xml
```

顯示

```
<schemalist>
	<schema id="org.test.demo" path="/org/test/demo/" gettext-domain="demo">
		<key name="to-be-or-not-to-be" type="b">
			<default>true</default>
			<summary>To be, or not to be</summary>
			<description>To be, or not to be?</description>
		</key>
	</schema>
</schemalist>
```

## 確認系統目前的「schemas」是有更新

執行

``` sh
$ grep 'to-be-or-not-to-be' /usr/share/glib-2.0/schemas/*
```

顯示

```
Binary file /usr/share/glib-2.0/schemas/gschemas.compiled matches
/usr/share/glib-2.0/schemas/org.test.demo.gschema.xml:		<key name="to-be-or-not-to-be" type="b">
```

## 移除「demo-schema」

執行

``` sh
$ sudo dpkg -r demo-schema
```

顯示

```
(Reading database ... 185696 files and directories currently installed.)
Removing demo-schema (0.1) ...
Processing triggers for libglib2.0-0:amd64 (2.54.1-1ubuntu1) ...
```


## 再次確認系統目前的「schemas」是否有更新

執行

``` sh
$ grep 'to-be-or-not-to-be' /usr/share/glib-2.0/schemas/* -R
```

沒有任何顯示，直接出現另一個提示字元。


## 說明

注意上面的，安裝和移除，都有出現如下的訊息

```
Processing triggers for libglib2.0-0:amd64 (2.54.1-1ubuntu1) ...
```


### /var/lib/dpkg/info/libglib2.0-0\:amd64.triggers

執行下面指令，觀看「/var/lib/dpkg/info/libglib2.0-0\:amd64.triggers」這個檔案

``` sh
$ cat /var/lib/dpkg/info/libglib2.0-0\:amd64.triggers
```

顯示

```
interest /usr/lib/x86_64-linux-gnu/gio/modules
interest /usr/lib/gio/modules
interest /usr/share/glib-2.0/schemas
# Triggers added by dh_makeshlibs/10.7.2ubuntu2
activate-noawait ldconfig
```

注意上面有一行「interest /usr/share/glib-2.0/schemas」。


### /var/lib/dpkg/info/libglib2.0-0\:amd64.postinst

執行下面指令，觀看「/var/lib/dpkg/info/libglib2.0-0\:amd64.postinst」這個檔案

``` sh
$ cat /var/lib/dpkg/info/libglib2.0-0\:amd64.postinst
```

顯示

``` sh
#!/bin/sh
set -e

if [ "$1" = triggered ]; then
    for trigger in $2; do
        if ! [ -d $trigger ]; then
            continue
        fi
        case $trigger in
          /usr/share/glib-2.0/schemas)
            # This is triggered everytime an application installs a
            # GSettings schema
            /usr/lib/x86_64-linux-gnu/glib-2.0/glib-compile-schemas /usr/share/glib-2.0/schemas || true
            ;;

          /usr/lib/x86_64-linux-gnu/gio/modules|/usr/lib/gio/modules)
            # This is triggered everytime an application installs a GIO
            # module into /usr/lib/x86_64-linux-gnu/gio/modules or the
            # backwards-compatible /usr/lib/gio/modules directory

            # The /usr/lib/gio/modules directory is no longer shipped by
            # libglib2.0 itself so we need to check to avoid a warning from
            # gio-querymodules
            dirs=/usr/lib/x86_64-linux-gnu/gio/modules
            if [ -d /usr/lib/gio/modules ] && [ $(dpkg --print-architecture) = amd64 ]; then
                dirs="$dirs /usr/lib/gio/modules"
            fi
            /usr/lib/x86_64-linux-gnu/glib-2.0/gio-querymodules $dirs || true
            ;;
        esac
    done
    exit 0
fi



# Also handle the initial installation
if [ -d /usr/share/glib-2.0/schemas ]; then
    /usr/lib/x86_64-linux-gnu/glib-2.0/glib-compile-schemas /usr/share/glib-2.0/schemas || true
fi
if [ -d /usr/lib/x86_64-linux-gnu/gio/modules ]; then
    /usr/lib/x86_64-linux-gnu/glib-2.0/gio-querymodules /usr/lib/x86_64-linux-gnu/gio/modules || true
fi
if [ -d /usr/lib/gio/modules ] && [ $(dpkg --print-architecture) = amd64 ]; then
    /usr/lib/x86_64-linux-gnu/glib-2.0/gio-querymodules /usr/lib/gio/modules || true
fi

```

可以看到其中有一段

``` sh
...略...

        case $trigger in
          /usr/share/glib-2.0/schemas)
            # This is triggered everytime an application installs a
            # GSettings schema
            /usr/lib/x86_64-linux-gnu/glib-2.0/glib-compile-schemas /usr/share/glib-2.0/schemas || true
            ;;

...略...

```

從剛剛「/var/lib/dpkg/info/libglib2.0-0\:amd64.triggers」看到的「interest /usr/share/glib-2.0/schemas」的設定。

當在安裝「demo.deb」這個「Debian Package」時，

因為有一個檔案「/usr/share/glib-2.0/schemas/org.test.demo.gschema.xml」，是在「/usr/share/glib-2.0/schemas」這個資料夾，

所以會觸發一個機制，然後執行到上面那段程式碼，

就會執行到「/usr/lib/x86_64-linux-gnu/glib-2.0/glib-compile-schemas /usr/share/glib-2.0/schemas」，

於是會重新產生「/usr/share/glib-2.0/schemas/gschemas.compiled」。


### /var/lib/dpkg/info/libglib2.0-0\:amd64.postrm

執行下面指令，觀看「/var/lib/dpkg/info/libglib2.0-0\:amd64.postrm」這個檔案

``` sh
$ cat /var/lib/dpkg/info/libglib2.0-0\:amd64.postrm
```

顯示

```
#! /bin/sh
set -e



if [ -d /usr/lib/x86_64-linux-gnu/gio/modules ]; then
    # Purge the cache
    rm -f /usr/lib/x86_64-linux-gnu/gio/modules/giomodule.cache
    rmdir -p --ignore-fail-on-non-empty /usr/lib/x86_64-linux-gnu/gio/modules
fi
if [ -d /usr/lib/gio/modules ]; then
    # Purge the cache
    if [ $(dpkg --print-architecture) = amd64 ]; then
        rm -f /usr/lib/gio/modules/giomodule.cache
        rmdir -p --ignore-fail-on-non-empty /usr/lib/gio/modules
    fi
fi

if [ "$1" = purge ] && [ -d /usr/share/glib-2.0/schemas ]; then
    # Purge the compiled schemas
    rm -f /usr/share/glib-2.0/schemas/gschemas.compiled
    rmdir -p --ignore-fail-on-non-empty /usr/share/glib-2.0/schemas

    # With multiarch enabled we can't be certain that the cache file
    # isn't needed for other architectures since it is not reference
    # counted. The best we can do is to fire a file trigger which will
    # regenerate the cache file if required.
    if [ -d /usr/share/glib-2.0/schemas ]; then
        dpkg-trigger /usr/share/glib-2.0/schemas
    fi
fi
```


## 更多參考

* https://wiki.gnome.org/Projects/dconf
* https://wiki.gnome.org/Projects/dconf/SystemAdministrators
* https://developer.gnome.org/GSettings/
* https://developer.gnome.org/gio/stable/GSettings.html
* https://developer.gnome.org/gio/stable/gsettings-tool.html
* https://developer.gnome.org/gio/stable/glib-compile-schemas.html
* https://developer.gnome.org/gio/stable/ch34s06.html
* [Vala Settings Sample](https://wiki.gnome.org/Projects/Vala/GSettingsSample)


## 相關檔案

* ~/.config/dconf/user
* /usr/share/glib-2.0/schemas/*
* /usr/share/glib-2.0/schemas/gschemas.compiled


## 相關指令

* [dconf](http://manpages.ubuntu.com/manpages/artful/en/man1/dconf.1.html)
* [gsettings](http://manpages.ubuntu.com/manpages/artful/en/man1/gsettings.1.html)
* [glib-compile-schemas](http://manpages.ubuntu.com/manpages/artful/en/man1/glib-compile-schemas.1.html)


## 專案樣版

此專案樣版，從「[demo-about-debian-package/example/build/basic](https://github.com/samwhelp/demo-about-debian-package/tree/master/example/build/basic)」修改而來。
