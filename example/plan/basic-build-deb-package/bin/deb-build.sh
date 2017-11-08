#!/usr/bin/env bash


## init
THE_BASE_DIR_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source $THE_BASE_DIR_PATH/_init.sh


## prepare dir
base_dir_prepare


## cd ../prj
cd $THE_PRJ_DIR_PATH
##pwd

## now in dir [prj]


## dpkg -b demo ../var/deb/
#dpkg -b $THE_MAIN_DIR_NAME $THE_DEB_DIR_PATH

## dpkg -b demo ../var/deb/demo.deb
dpkg -b $THE_MAIN_DIR_NAME $THE_DEB_FILE_PATH


## NOTE:
## [dpkg -b] = [dpkg-deb -b]
## man dpkg
## man dpkg-deb
## -b, --build binary-directory [archive|directory]
