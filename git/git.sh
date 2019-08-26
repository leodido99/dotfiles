#!/usr/bin/env bash
# Setup git

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

# Setup symlinks
NAME=".gitconfig"
SRC="$DIR/$NAME"
DST="$HOME/$NAME"
$DIR/../tools/sym_link.sh $SRC $DST

NAME=".gitignore"
SRC="$DIR/$NAME"
DST="$HOME/$NAME"
$DIR/../tools/sym_link.sh $SRC $DST

NAME="commit-msg"
SRC="$DIR/$NAME"
DST="$HOME/.git/hooks/$NAME"
$DIR/../tools/sym_link.sh $SRC $DST
