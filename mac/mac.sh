#!/usr/bin/env bash

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

brew install zsh

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

# Setup symlinks
NAME=".zshrc"
SRC="$DIR/../zsh/$NAME"
DST="$HOME/$NAME"
$DIR/../tools/sym_link.sh $SRC $DST

