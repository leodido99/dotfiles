#!/usr/bin/env bash
# Setup urxvt

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

DSTDIR="$HOME/.fonts"

# Have to use multilangue rxvt otherwise unicode3 not compiled in and power line don't work
sudo dnf install rxvt-unicode-ml

# Clone nord theme
git clone https://github.com/arcticicestudio/nord-xresources.git $HOME/gitrepo/nord-xresources

# Get font
cd $DSTDIR
 curl -fLo "Sauce Code Pro Nerd Font Complete Mono.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf

fc-cache -fv $DSTDIR

SRC="$DIR/.Xresources"
DST="$HOME/.Xresources"
$DIR/../tools/sym_link.sh $SRC $DST
