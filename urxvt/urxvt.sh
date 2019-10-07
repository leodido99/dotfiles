#!/usr/bin/env bash
# Setup urxvt

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

DSTDIR="$HOME/.fonts"

# Have to use multilangue rxvt otherwise unicode3 not compiled in and power line don't work
sudo dnf install rxvt-unicode-256color-ml

# Clone nord theme
git clone https://github.com/arcticicestudio/nord-xresources.git $HOME/gitrepo/nord-xresources

# Get font
cd $DSTDIR
curl -fLo "Sauce Code Pro Nerd Font Complete Mono.ttf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce Code Pro Nerd Font Complete Mono.ttf"

fc-cache -fv $DSTDIR

SRC="$DIR/.Xresources"
DST="$HOME/.Xresources"
$DIR/../tools/sym_link.sh $SRC $DST
