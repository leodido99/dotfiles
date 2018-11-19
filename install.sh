#!/bin/bash
# Install dotfiles

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

# Install apps
pkgs="vim git tmux chromium-browser zsh"
sudo $installcmd $pkgs

# Change default shell to zsh
chsh -s $(which zsh)

# Setup symlinks
rm -f $HOME/.vimrc
ln -s $PWD/vim/.vimrc $HOME/.vimrc
rm -f $HOME/.tmux.conf
ln -s $PWD/tmux/.tmux.conf $HOME/.tmux.conf
rm -rf $HOME/.scripts
ln -s $PWD/scripts $HOME/.scripts
rm -rf $HOME/.profile
ln -s $PWD/term/.profile $HOME/.profile
rm -rf $HOME/.zshrc
ln -s $PWD/zsh/.zshrc $HOME/.zshrc
rm -rf $HOME/.zkbd
ln -s $PWD/zsh/.zkbd $HOME/.zkdb

# Setup vim
if [ ! -d $HOME/.vim/autoload ]; then
	bundlepath=$HOME/.vim/bundle
	mkdir -p $HOME/.vim/autoload $bundlepath && \
	curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
	# Clone plugins
	cd $bundlepath
	# vim-fugitive
	git clone https://github.com/tpope/vim-fugitive.git
	vim -u NONE -c "helptags vim-fugitive/doc" -c q
	# solarized8
	git clone https://github.com/lifepillar/vim-solarized8.git
	vim -u NONE -c "helptags vim-solarized8/doc" -c q
	# Ultisnips
	git clone https://github.com/SirVer/ultisnips.git
	vim -u NONE -c "helptags ultisnips/doc" -c q
	# Snippets
	git clone https://github.com/honza/vim-snippets.git
	vim -u NONE -c "helptags vim-snippets/doc" -c q

	# vim-bufkill
	git clone https://github.com/qpkorr/vim-bufkill ~/.vim/bundle/vim-bufkill
	vim -u NONE -c "helptags vim-bufkill/doc" -c q
fi



