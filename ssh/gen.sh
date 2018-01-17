#!/bin/bash
read -p "Service name: " file

if [ -e ${file} ]; then
	echo "File already exist"
	exit 0
fi

ssh-keygen -Z rsa -f ${file}
chmod 0600 ${file} ${file}.pub

