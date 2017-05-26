#!/usr/bin/env bash


## 建立專案資料夾
mkdir -p demo/DEBIAN
mkdir -p demo/usr/bin


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

echo 'Hi!'

EOF


## 設定執行權限
chmod +x demo/usr/bin/demo
