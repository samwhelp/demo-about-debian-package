## THE_BASE_DIR_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

find_dir_path () {
	if [ ! -d $(dirname -- "$1") ]; then
		dirname -- "$1"
		return 1
	fi
	echo $(cd -P -- "$(dirname -- "$1")" && pwd -P)
}

##THIS_BASE_DIR_PATH=$(find_dir_path $0)

base_var_init () {

	THE_PLAN_DIR_PATH=$(find_dir_path "$THE_BASE_DIR_PATH/../.")
	THE_DOCUMENTROOT_DIR_PATH="$THE_PLAN_DIR_PATH"

	THE_BIN_DIR_NAME=bin
	THE_BIN_DIR_PATH=$(find_dir_path "$THE_PLAN_DIR_PATH/$THE_BIN_DIR_NAME/.")

	THE_PRJ_DIR_NAME=prj
	THE_PRJ_DIR_PATH=$(find_dir_path "$THE_PLAN_DIR_PATH/$THE_PRJ_DIR_NAME/.")

	THE_MAIN_DIR_NAME=demo
	THE_MAIN_DIR_PATH=$(find_dir_path "$THE_PRJ_DIR_PATH/$THE_MAIN_DIR_NAME/.")

	THE_VAR_DIR_NAME=var
	THE_VAR_DIR_PATH=$(find_dir_path "$THE_PLAN_DIR_PATH/$THE_VAR_DIR_NAME/.")

	THE_DEB_DIR_NAME=deb
	THE_DEB_DIR_PATH=$(find_dir_path "$THE_VAR_DIR_PATH/$THE_DEB_DIR_NAME/.")

	THE_DEB_PKG_NAME=demo
	THE_DEB_EXT_NAME=deb
	THE_DEB_FILE_NAME="$THE_DEB_PKG_NAME.$THE_DEB_EXT_NAME"
	THE_DEB_FILE_PATH="$THE_DEB_DIR_PATH/$THE_DEB_FILE_NAME"

}

base_var_dump () {
	echo
	echo "### var_dump ###"
	echo "#"
	echo "#"


	echo "THE_PLAN_DIR_PATH=$THE_PLAN_DIR_PATH"
	echo "THE_DOCUMENTROOT_DIR_PATH=$THE_DOCUMENTROOT_DIR_PATH"

	echo "THE_BIN_DIR_NAME=$THE_BIN_DIR_NAME"
	echo "THE_BIN_DIR_PATH=$THE_BIN_DIR_PATH"

	echo "THE_PRJ_DIR_NAME=$THE_PRJ_DIR_NAME"
	echo "THE_PRJ_DIR_PATH=$THE_PRJ_DIR_PATH"

	echo "THE_MAIN_DIR_NAME=$THE_MAIN_DIR_NAME"
	echo "THE_MAIN_DIR_PATH=$THE_MAIN_DIR_PATH"

	echo "THE_VAR_DIR_NAME=$THE_VAR_DIR_NAME"
	echo "THE_VAR_DIR_PATH=$THE_VAR_DIR_PATH"

	echo "THE_DEB_DIR_NAME=$THE_DEB_DIR_NAME"
	echo "THE_DEB_DIR_PATH=$THE_DEB_DIR_PATH"

	echo "THE_DEB_PKG_NAME=$THE_DEB_PKG_NAME"
	echo "THE_DEB_EXT_NAME=$THE_DEB_EXT_NAME"
	echo "THE_DEB_FILE_NAME=$THE_DEB_FILE_NAME"
	echo "THE_DEB_FILE_PATH=$THE_DEB_FILE_PATH"


	echo "#"
	echo "#"
	echo "### var_dump ###"
	echo
}


base_dir_prepare () {
	## mkdir -p ../prj
	##echo mkdir -p $THE_PRJ_DIR_PATH
	mkdir -p $THE_PRJ_DIR_PATH
	## mkdir -p ../var/deb
	## echo mkdir -p $THE_DEB_DIR_PATH
	mkdir -p $THE_DEB_DIR_PATH
}
