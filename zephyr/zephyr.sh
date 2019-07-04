#!/usr/bin/bash
# Setup zephyr
# arg: OS

if [ "$#" -ne 1 ]; then
    echo "You must specify the OS"
    exit
fi

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

read -p "Do you want to setup the system for Zephyr? [y/n]" -n 1 -r
echo
echo $REPLY
if [ "$REPLY" == "y" ]; then

if [ $1 = "Ubuntu" ]; then
sudo apt-get install --no-install-recommends git ninja-build gperf \
  ccache dfu-util device-tree-compiler wget \
  python3-pip python3-setuptools python3-wheel xz-utils file make gcc \
  gcc-multilib

elif [ $1 = "Fedora" ]; then
sudo dnf group install "Development Tools" "C Development Tools and Libraries"
sudo dnf install git ninja-build gperf ccache dfu-util dtc wget \
  python3-pip xz file glibc-devel.i686 libstdc++-devel.i686
sudo dnf install protobuf-compiler
else
	echo "$OS not supported"
	exit 1
fi

# Clone Zephyr repo
git clone https://github.com/zephyrproject-rtos/zephyr.git $HOME/gitrepo/zephyr

# Install python dependencies
pip3 install --user -r $HOME/gitrepo/zephyr/scripts/requirements.txt

# Install cmake through pip3 otherwise version is too old
pip3 install --user cmake

# Install protobuf
pip3 install --user protobuf

# Clone Zephyr SDK
if [ ! -d /opt/zephyr-sdk ]; then
	SDK_VER="0.9.5"
	wget -P ~/Downloads  https://github.com/zephyrproject-rtos/meta-zephyr-sdk/releases/download/${SDK_VER}/zephyr-sdk-${SDK_VER}-setup.run
	cd ~/Downloads
	sudo sh zephyr-sdk-${SDK_VER}-setup.run
	rm zephyr-sdk-${SDK_VER}-setup.run
fi

# Setup symlinks
NAME=".zephyrrc_SDK_0_10_0"
DSTDIR="$HOME"
SRCDIR="$DIR"
if [ ! -L $DSTDIR/$NAME ]; then
	echo "Setting $DSTDIR/$NAME symlink"
	rm -rf $DSTDIR/$NAME
	ln -s $SRCDIR/$NAME $DSTDIR/$NAME
else
	echo "$DSTDIR/$NAME symlink already set"
fi

NAME=".zephyrrc_SDK_0_9_5"
DSTDIR="$HOME"
SRCDIR="$DIR"
if [ ! -L $DSTDIR/$NAME ]; then
	echo "Setting $DSTDIR/$NAME symlink"
	rm -rf $DSTDIR/$NAME
	ln -s $SRCDIR/$NAME $DSTDIR/$NAME
else
	echo "$DSTDIR/$NAME symlink already set"
fi

fi
