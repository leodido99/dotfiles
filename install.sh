#!/usr/bin/env bash
# Install dotfiles
# TODO:
# - Harmonize install script parameters (OS and INSTALLCMD for all)

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

# Determine package manager
source $DIR/../tools/pkg_mgr.sh

echo "#########################################################################"
echo "Leo's dotfiles install script"
echo "#########################################################################"

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

echo "OS: $OS ver $VER"

echo "Using $INSTALLCMD to manage packages"
echo ""

echo "#########################################################################"
echo "Upgrade system"
echo "#########################################################################"
sudo $INSTALLCMD upgrade
echo ""

pkgs="vim vim-X11 tmux zsh python3 python3-pip gnome-tweaks"

echo "#########################################################################"
echo "Install packages: $pkgs"
echo "#########################################################################"
sudo $INSTALLCMD install $pkgs
echo ""

echo "#########################################################################"
echo "Install Chrome"
echo "#########################################################################"
sudo $INSTALLCMD install fedora-workstation-repositories
sudo $INSTALLCMD config-manager --set-enabled google-chrome
sudo $INSTALLCMD install google-chrome-stable
echo ""

echo "#########################################################################"
echo "Setup git"
echo "#########################################################################"
$DIR/git/git.sh
echo ""

echo "#########################################################################"
echo "Setup fonts"
echo "#########################################################################"
$DIR/fonts/fonts.sh
echo ""

echo "#########################################################################"
echo "Setup zsh"
echo "#########################################################################"
$DIR/zsh/zsh.sh
echo ""

echo "#########################################################################"
echo "Setup vim"
echo "#########################################################################"
$DIR/vim/vim.sh
echo ""

#echo "#########################################################################"
#echo "Setup tmux"
#echo "#########################################################################"
#$DIR/tmux/tmux.sh
#echo ""

echo "#########################################################################"
echo "Setup terminal"
echo "#########################################################################"
$DIR/term/term.sh
echo ""

echo "#########################################################################"
echo "Setup scripts"
echo "#########################################################################"
# Setup symlinks
SRC="$DIR/scripts"
DST="$HOME/.scripts"
$DIR/../tools/sym_link.sh $SRC $DST
echo ""

echo "#########################################################################"
echo "Setup user"
echo "#########################################################################"
$DIR/user/user.sh $OS
echo ""

echo "#########################################################################"
echo "Setup Zephyr"
echo "#########################################################################"
$DIR/zephyr/zephyr.sh $OS
echo ""

echo "#########################################################################"
echo "Setup i3"
echo "#########################################################################"
$DIR/i3/i3.sh
echo ""

exit
