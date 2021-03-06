#!/usr/bin/env bash
# Setup vim

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

if [ ! -d $HOME/.vim/autoload ]; then
	# Install pathogen
	BUNDLE=$HOME/.vim/bundle
	mkdir -p $HOME/.vim/autoload $BUNDLE && \
	curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

	# Install vim plugins
	PLUGIN="ultisnips"
	REPO="https://github.com/SirVer/ultisnips.git"
	git clone $REPO $BUNDLE/$PLUGIN
	vim -u NONE -c "helptags $BUNDLE/$PLUGIN/doc" -c q

	PLUGIN="vim-fugitive"
	REPO="https://github.com/tpope/vim-fugitive.git"
	git clone $REPO $BUNDLE/$PLUGIN
	vim -u NONE -c "helptags $BUNDLE/$PLUGIN/doc" -c q

	PLUGIN="vim-snippets"
	REPO="https://github.com/lbise/vim-snippets.git"
	git clone $REPO $BUNDLE/$PLUGIN
	vim -u NONE -c "helptags $BUNDLE/$PLUGIN/doc" -c q

	PLUGIN="vim-airline"
	REPO="https://github.com/vim-airline/vim-airline.git"
	git clone $REPO $BUNDLE/$PLUGIN
	vim -u NONE -c "helptags $BUNDLE/$PLUGIN/doc" -c q

	PLUGIN="vim-airline-themes"
	REPO="https://github.com/vim-airline/vim-airline-themes.git"
	git clone $REPO $BUNDLE/$PLUGIN
	vim -u NONE -c "helptags $BUNDLE/$PLUGIN/doc" -c q

	PLUGIN="vim-syntax-extra"
	REPO="https://github.com/justinmk/vim-syntax-extra.git"
	git clone $REPO $BUNDLE/$PLUGIN
	vim -u NONE -c "helptags $BUNDLE/$PLUGIN/doc" -c q

	PLUGIN="nord-vim"
	REPO="https://github.com/arcticicestudio/nord-vim.git"
	git clone $REPO $BUNDLE/$PLUGIN
	vim -u NONE -c "helptags $BUNDLE/$PLUGIN/doc" -c q

	PLUGIN="vim-bufkill"
	REPO="https://github.com/qpkorr/vim-bufkill"
	git clone $REPO $BUNDLE/$PLUGIN
	vim -u NONE -c "helptags $BUNDLE/$PLUGIN/doc" -c q

	PLUGIN="vim-obsession"
	REPO="https://github.com/tpope/vim-obsession.git"
	git clone $REPO $BUNDLE/$PLUGIN
	vim -u NONE -c "helptags $BUNDLE/$PLUGIN/doc" -c q
	# Create session file folder
	mkdir -p $HOME/.vimsession
fi

# Setup symlinks
NAME=".vimrc"
SRC="$DIR/$NAME"
DST="$HOME/$NAME"
$DIR/../tools/sym_link.sh $SRC $DST

# Create after directory used at add additional configs to vim
mkdir $HOME/.vim/after

NAME="syntax"
SRC="$DIR/$NAME"
DST="$HOME/.vim/after/$NAME"
$DIR/../tools/sym_link.sh $SRC $DST

