#!/bin/bash

# list of tools

tools = (
	"binwalk"
	"git"
	"python3"
	"python3-pip"
	"gdb"
)

# check for sudo
if [ "$(id -u)" -ne 0 ]; then
	echo "This script requires sudo privileges :("
	exit 1
fi

mkdir CTFTools
cd CTFTools

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
	git clone https://github.com/iBotPeaches/Apktool
	# should add more here
	
	# barf
	# should add more here
	
	# binary ninja
	# add more here

	# binutils
	# add more here

	# boomerang
	# add more here

	# ctf_import
	git clone https://github.com/sciencemanx/ctf_import

	# cwe_checker
	docker build -t cwe_checker .

	# demovfuscator
	# work in progress, so skipping

	# frida
	pip install frida-tools
	pip install frida
	npm install frida

	# GEF
	bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

	# Hopper
	git clone https://github.com/FuzzAnything/Hopper
	cd Hopper
	./build.sh
	cd ..

	# Jadx
	# add more here

	# Java decompilers
	git clone https://github.com/java-decompiler/jd-gui.git
	cd jd-gui
	./gradlew build
	cd ..

	# Krakatau
	git clone https://github.com/Storyyeller/Krakatau.git
	cd Krakatau
	cargo build --release
	cd ..

	# objection
	pip3 install objection

	# PEDA
	# add more

	# pin
	# add more

	# PINCE
	# download the release from github

	# PinCTF
	git clone https://github.com/ChrisTheCoolHut/PinCTF
	cd PinCTF
	./installPin.sh
	cd ..

	# Plasma
	# add more

	
}

other_tools() {
	echo "Installing other useful programs ..."

	# docker
	for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
	# Add Docker's official GPG key:
	apt-get update
	apt-get install ca-certificates curl
	install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	echo \
  	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  	$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  	 tee /etc/apt/sources.list.d/docker.list > /dev/null
	apt-get update

	apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	
}

install_debian

other_tools

gitHub_tools

