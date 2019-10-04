#!/bin/zsh
# map this script on your i3 config.

# change as needed
DEFAULT_IMGS="$HOME/gitrepo/wallpapers"

if [[ -z $1 ]] ; then
    img_dir=$DEFAULT_IMGS
else
    img_dir=$1
fi;

randfile=$(ls $img_dir | sort -R | head -n1)
i3lock -e -c 000000 -u -i $img_dir/$randfile
