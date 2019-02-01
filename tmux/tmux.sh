#!/usr/bin/bash
# Setup tmux

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Install plugins by running prefix + I in tmux"

# Setup symlinks
NAME=".tmux.conf"
DSTDIR="$HOME"
SRCDIR="$DIR"
if [ ! -L $DSTDIR/$NAME ]; then
	echo "Setting $DSTDIR/$NAME symlink"
	rm -rf $DSTDIR/$NAME
	ln -s $SRCDIR/$NAME $DSTDIR/$NAME
else
	echo "$DSTDIR/$NAME symlink already set"
fi
