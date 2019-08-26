#!/usr/bin/env bash
# Setup terminal

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

# Setup symlinks
NAME=".profile"
SRC="$DIR/$NAME"
DST="$HOME/$NAME"
$DIR/../tools/sym_link.sh $SRC $DST

# Install gnome-terminal nord theme
git clone https://github.com/arcticicestudio/nord-gnome-terminal.git $DIR/../../nord-gnome-terminal
$DIR/../../nord-gnome-terminal/src/nord.sh
echo "TODO Set Nord as default gnome-terminal profile"
