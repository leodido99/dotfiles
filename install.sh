#!/bin/bash
# Install dotfiles

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
	installcmd="apt-get install "
elif [ $OS = "Fedora" ]; then
	installcmd="dnf install "
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
git/git.sh
echo ""

echo "#########################################################################"
echo "Setup fonts"
echo "#########################################################################"
fonts/fonts.sh
echo ""

echo "#########################################################################"
echo "Setup zsh"
echo "#########################################################################"
zsh/zsh.sh
echo ""

echo "#########################################################################"
echo "Setup vim"
echo "#########################################################################"
vim/vim.sh
echo ""

echo "#########################################################################"
echo "Setup tmux"
echo "#########################################################################"
tmux/tmux.sh
echo ""



# TODO Start system updates

exit





# Setup symlinks
rm -f $HOME/.tmux.conf
ln -s $PWD/tmux/.tmux.conf $HOME/.tmux.conf
rm -rf $HOME/.scripts
ln -s $PWD/scripts $HOME/.scripts
rm -rf $HOME/.profile
ln -s $PWD/term/.profile $HOME/.profile




