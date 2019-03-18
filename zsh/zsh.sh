#!/usr/bin/bash
# Setup zsh

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

# Change default shell to zsh
chsh -s $(which zsh)

# Install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install powerlevel10k skin for oh my zsh
NAME=powerlevel10k
DSTDIR="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
if [ ! -d "$DSTDIR" ]; then
	git clone https://github.com/romkatv/powerlevel10k.git $DSTDIR
else
	echo "$NAME already installed"
fi

# Install pygments for zsh colorized plugin
pip3 install --user pygments

# Setup symlinks
NAME=".zshrc"
DSTDIR="$HOME"
SRCDIR="$DIR"
if [ ! -L $DSTDIR/$NAME ]; then
	echo "Setting $DSTDIR/$NAME symlink"
	rm -rf $DSTDIR/$NAME
	ln -s $SRCDIR/$NAME $DSTDIR/$NAME
else
	echo "$DSTDIR/$NAME symlink already set"
fi

NAME=".zkbd"
DSTDIR="$HOME"
SRCDIR="$DIR"
if [ ! -L $DSTDIR/$NAME ]; then
	echo "Setting $DSTDIR/$NAME symlink"
	rm -rf $DSTDIR/$NAME
	ln -s $SRCDIR/$NAME $DSTDIR/$NAME
else
	echo "$DSTDIR/$NAME symlink already set"
fi
