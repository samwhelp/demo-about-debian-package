#!/usr/bin/env bash


## 建立專案資料夾
mkdir -p demo/DEBIAN


## 產生「demo/DEBIAN/control」
cat > demo/DEBIAN/control << EOF
Package: demo
Version: 0.1
Architecture: all
Description: This is a test package.
Maintainer: developer <developer@home.heaven>

EOF


## 產生「demo/DEBIAN/postinst」
cat > demo/DEBIAN/postinst << EOF
#!/bin/sh

xxxxx

EOF

## 設定「demo/DEBIAN/postinst」權限
chmod 775 demo/DEBIAN/postinst
