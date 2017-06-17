#!/usr/bin/env bash


## 建立專案資料夾
mkdir -p demo/DEBIAN
mkdir -p demo/usr/bin
mkdir -p demo/usr/share/package-data-downloads


## 產生「demo/DEBIAN/control」
cat > demo/DEBIAN/control << EOF
Package: demo
Version: 0.1
Architecture: all
Description: This is a test package.
Maintainer: developer <developer@home.heaven>

EOF


## 產生「demo/usr/bin/demo」
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


## 設定執行權限
chmod +x demo/usr/bin/demo

## 產生「demo/usr/share/package-data-downloads/demo」
cat > demo/usr/share/package-data-downloads/demo << EOF

Url: https://raw.githubusercontent.com/samwhelp/demo-about-debian-package/master/download/demo.txt
Sha256: 0f0af810c640b514ea0cc792ac03611b978928465d9cd43b607d236848969c7f

Script: /usr/bin/demo

EOF
