#!/usr/bin/env bash


## 建立專案資料夾
mkdir -p demo-schema-override/DEBIAN
mkdir -p demo-schema-override/usr/share/glib-2.0/schemas


## 產生「demo-schema/DEBIAN/control」
cat > demo-schema-override/DEBIAN/control << EOF
Package: demo-schema-override
Version: 0.1
Architecture: all
Description: This is a demo package for gsettings schema override.
Maintainer: developer <developer@home.heaven>

EOF


## 產生「demo-schema-override/usr/share/glib-2.0/schemas/90_test-demo.gschema.override」
cat > demo-schema-override/usr/share/glib-2.0/schemas/90_test-demo.gschema.override << EOF
[org.test.demo]
to-be-or-not-to-be=false

EOF
