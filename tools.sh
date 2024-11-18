#!/bin/bash

# list of tools

tools = (
	"binwalk"
	"git"
	"python3"
	"python3-pip"
)

# check for sudo
if [ "$(id -u)" -ne 0 ]; then
	echo "This script requires sudo privileges :("
	exit 1
fi

install_debian() {
	echo "Installing tools for Debian-based system"
	apt update && apt upgrade -y
	for tool in "${tools[@]}"; do
		echo "Installing $tool ..."
		apt install -y "$tool"
	done
}

gitHub_tools() {
	echo "Installing GitHub tools ..."

	echo "Creating directory ... "
	mkdir GitHubTools
	cd GitHubTools

	echo "Downloading Reverse engineering and Binary exploitatin tools ..."
	mkdir RevEng
	cd RevEng
	
	# libformatstr
	git clone https://github.com/hellman/libformatstr

	# pwntools
	sudo apt-get update
	sudo apt-get install -y python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential
	python3 -m pip install --upgrade pip
	python3 -m pip install --upgrade pwntools

	# qira
	git clone https://github.com/geohot/qira.git
	cd qira
	./install.sh
	cd ..

	# ROPgadget
	apt install python3-pip
	sudo -H python3 -m pip install ROPgadget

	# androguard
	pip install androguard

	# angr
	python -m pip install angr

	# apk2gold
	git clone https://github.com/lxdvs/apk2gold
	cd apk2gold
	./make.sh
	cd ..

	# apktool
	https://github.com/iBotPeaches/Apktool
	# should add more here
	
	# barf
	# should add more here
	
	
}

install_debian



