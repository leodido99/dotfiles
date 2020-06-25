#!/usr/bin/env bash
# Setup ctags
# $1: OS

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

source $DIR/../tools/pkg_mgr.sh

sudo $INSTALLCMD ctags

# Setup symlinks
# Exuberant ctags
NAME=".ctags"
SRC="$DIR/$NAME"
DST="$HOME/$NAME"
$DIR/../tools/sym_link.sh $SRC $DST

# Universal ctags
NAME=".ctags"
SRC="$DIR/$NAME"
DST="$HOME/.ctags.d/default$NAME"
$DIR/../tools/sym_link.sh $SRC $DST
