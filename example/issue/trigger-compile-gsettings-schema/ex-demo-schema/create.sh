#!/usr/bin/env bash


## 建立專案資料夾
mkdir -p demo-schema/DEBIAN
mkdir -p demo-schema/usr/share/glib-2.0/schemas


## 產生「demo-schema/DEBIAN/control」
cat > demo-schema/DEBIAN/control << EOF
Package: demo-schema
Version: 0.1
Architecture: all
Description: This is a demo package for gsettings schema.
Maintainer: developer <developer@home.heaven>

EOF


## 產生「demo-schema/usr/share/glib-2.0/schemas/org.test.demo.gschema.xml」
cat > demo-schema/usr/share/glib-2.0/schemas/org.test.demo.gschema.xml << EOF
<schemalist>
	<schema id="org.test.demo" path="/org/test/demo/" gettext-domain="demo">
		<key name="to-be-or-not-to-be" type="b">
			<default>true</default>
			<summary>To be, or not to be</summary>
			<description>To be, or not to be?</description>
		</key>
	</schema>
</schemalist>

EOF
