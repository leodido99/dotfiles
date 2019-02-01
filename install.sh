#!/bin/bash
# Install dotfiles

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

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

if [ $OS = "Ubuntu" ]; then
	installcmd="apt-get install"
elif [ $OS = "Fedora" ]; then
	installcmd="dnf install"
else
	echo "$OS not supported"
	exit 1
fi

echo "Using $installcmd to install packages"
echo ""

pkgs="vim vim-X11 tmux zsh python3 python3-pip gnome-tweaks"

echo "#########################################################################"
echo "Installing packages: $pkgs"
echo "#########################################################################"
sudo $installcmd $pkgs
echo ""

echo "#########################################################################"
echo "Installing Chrome"
echo "#########################################################################"
sudo dnf install fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install google-chrome-stable
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

echo "#########################################################################"
echo "Setup tmux"
echo "#########################################################################"
$DIR/tmux/tmux.sh
echo ""

echo "#########################################################################"
echo "Setup terminal"
echo "#########################################################################"
$DIR/term/term.sh
echo ""

echo "#########################################################################"
echo "Setup scripts"
echo "#########################################################################"
# Setup symlinks
NAME=".scripts"
DSTDIR="$HOME"
SRCDIR="$DIR/scripts"
if [ ! -L $DSTDIR/$NAME ]; then
	echo "Setting $DSTDIR/$NAME symlink"
	rm -rf $DSTDIR/$NAME
	ln -s $SRCDIR $DSTDIR/$NAME
else
	echo "$DSTDIR/$NAME symlink already set"
fi
echo ""



# TODO Start system updates

exit
