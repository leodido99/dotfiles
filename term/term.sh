#!/usr/bin/bash
# Setup terminal

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

# Setup symlinks
NAME=".profile"
DSTDIR="$HOME"
SRCDIR="$DIR"
if [ ! -L $DSTDIR/$NAME ]; then
	echo "Setting $DSTDIR/$NAME symlink"
	rm -rf $DSTDIR/$NAME
	ln -s $SRCDIR/$NAME $DSTDIR/$NAME
else
	echo "$DSTDIR/$NAME symlink already set"
fi

# Install gnome-terminal nord theme
git clone https://github.com/arcticicestudio/nord-gnome-terminal.git $DIR/../../nord-gnome-terminal
$DIR/../../nord-gnome-terminal/src/nord.sh
echo "TODO Set Nord as default gnome-terminal profile"
