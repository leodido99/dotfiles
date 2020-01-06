#!/usr/bin/env bash

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

# .gdbinit is gdb dashboard https://github.com/cyrus-and/gdb-dashboard/
wget -P ~ https://git.io/.gdbinit

# Instal pygments for synthax highlighting
pip install --user pygments

# When using dashboard, user files are stored in .gdbinit.d folder
SRC="$DIR/.gdbinit.d"
DST="$HOME/.gdbinit.d"
$DIR/../tools/sym_link.sh $SRC $DST
