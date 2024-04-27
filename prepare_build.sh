#!/bin/sh 

MOUNTED_VOL_DIR_NAME="mounted_volume"
PY_SRC_DIR_NAME="py_src"
PY3_SRC_PATH="${MOUNTED_VOL_DIR_NAME}/${PY_SRC_DIR_NAME}"
PY3_SRC_URL="https://www.python.org/ftp/python/3.7.17/Python-3.7.17.tgz"

print_and_quit() {
	rc="${1:-1}"
	message="${2:-error error error}"
	echo "${message}"
	exit ${rc}
}

check_py_src_path() {
	wanted_path=$1
	echo "validating py src dir existence at: ${wanted_path}"
	if [ ! -d ${wanted_path} ]; then
		echo "Directory ${wanted_path} does not exists, recreating"
		mkdir -p ${wanted_path}
		rc=$?
		if [ ${rc} -ne 0 ]; then
			print_and_quit 1  "Was not able to create dir: ${wanted_path}"
		fi
	else
		echo -e "\tV path exists"
	fi
}

download_py_src_from_url() {
	url=$1
	target_path=$2
	echo "url is: ${url}, target_dir is: ${target_path}"
	(cd ${target_path} && curl -O ${url})
	rc=$?
	if [ ${rc} -ne 0 ]; then
		print_and_quit 2 "Was not able to download src from url"
	fi
	echo "Downloaded file details: "
	(cd ${target_path} && ls -l Python-*.tgz)
	echo -e "\tV tar downloaded"
}

unzip_py_tar() {
	target_path=$1
	echo "Extracting src files at: ${target_path}"
	(cd $target_path && tar -xzvf Python-*.tgz)
	rc=$?
	if [ ${rc} -ne 0 ]; then
		print_and_quit 3 "Was not able to extract src from tar"
	fi
	echo -e "\tV tar unzipped"

}


echo "Welcome to setup of build env for python3"
echo "PY_SRC_PATH is: ${PY3_SRC_PATH}"
check_py_src_path ${PY3_SRC_PATH}
echo "Pulling python source from: ${PY3_SRC_URL}"
download_py_src_from_url ${PY3_SRC_URL} ${PY3_SRC_PATH}
unzip_py_tar ${PY3_SRC_PATH}
echo -e "VVV\tFinished successfully"


