#!/usr/bin/env bash

## init
THE_BASE_DIR_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source $THE_BASE_DIR_PATH/_init.sh


usage()
{
	echo
	echo 'Usage: make [command]'
	echo
	cat <<EOF
Ex:
$ make
$ make help

$ make serve

$ make deb-build
$ make deb-clean

$ make deb-install
$ make deb-remove

EOF
}

usage
