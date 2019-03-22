#!/usr/bin/bash
# Setup i3
# $1: OS
# $2: Install command

INSTALLCMD=$2

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

# Install i3
sudo $INSTALLCMD i3 i3status i3lock dmenu feh xautolock

# Setup symlinks
NAME=".config/i3/config"
DSTDIR="$HOME"
SRCDIR="$DIR/config"
if [ ! -L $DSTDIR/$NAME ]; then
	echo "Setting $DSTDIR/$NAME symlink"
	rm -rf $DSTDIR/$NAME
	ln -s $SRCDIR $DSTDIR/$NAME
else
	echo "$DSTDIR/$NAME symlink already set"
fi

NAME=".config/i3status/config"
DSTDIR="$HOME"
SRCDIR="$DIR/i3statusconfig"
if [ ! -L $DSTDIR/$NAME ]; then
	echo "Setting $DSTDIR/$NAME symlink"
	rm -rf $DSTDIR/$NAME
	ln -s $SRCDIR $DSTDIR/$NAME
else
	echo "$DSTDIR/$NAME symlink already set"
fi

