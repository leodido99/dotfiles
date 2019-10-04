#!/usr/bin/env bash
# Setup fonts

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

DSTDIR="$HOME/.fonts"
SRCDIR="$DIR"

if [ ! -d "$DSTDIR" ]; then
	mkdir $DSTDIR
fi

# Copy fonts
NAME="SourceCodePro+Powerline+Awesome+Regular"
cp $SRCDIR/$NAME.ttf $DSTDIR
NAME="devicons-regular"
cp $SRCDIR/$NAME.ttf $DSTDIR
cp $SRCDIR/$NAME.sh $DSTDIR
NAME="fontawesome-regular"
cp $SRCDIR/$NAME.ttf $DSTDIR
cp $SRCDIR/$NAME.sh $DSTDIR
NAME="octicons-regular"
cp $SRCDIR/$NAME.ttf $DSTDIR
cp $SRCDIR/$NAME.sh $DSTDIR
NAME="pomicons-regular"
cp $SRCDIR/$NAME.ttf $DSTDIR
cp $SRCDIR/$NAME.sh $DSTDIR

# Nerd font
cd $DSTDIR
curl -fLo "Sauce Code Pro Nerd Font Complete Mono.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf

cd $DIR

# Update font cache
fc-cache -fv $DSTDIR

# Set fonts in gnome
gsettings set org.gnome.desktop.interface monospace-font-name 'SourceCodePro+Powerline+Awesome Regular, 12'
