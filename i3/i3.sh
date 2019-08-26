#!/usr/bin/env bash
# Setup i3
# $1: OS

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

source $DIR/../tools/pkg_mgr.sh

# Install i3
sudo $INSTALLCMD i3 i3status i3lock dmenu feh xautolock

# Setup symlinks
NAME="config"
DSTFOLDER=".config/i3"
SRC="$DIR/$NAME"
DST="$HOME/$DSTFOLDER/$NAME"
$DIR/../tools/sym_link.sh $SRC $DST

NAME="config"
DSTFOLDER=".config/i3status"
SRC="$DIR/i3statusconfig"
DST="$HOME/$DSTFOLDER/$NAME"
$DIR/../tools/sym_link.sh $SRC $DST
