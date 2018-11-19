# Bindings
function setkeybind {
	if [ "${key[$1]}" != "" ]; then
		bindkey "${key[$1]}" $2
	else
		echo "No key code for $1"
	fi
}

if [ -f "$HOME/.zkbd/$TERM-:0" ]; then
	source $HOME/.zkbd/$TERM-:0
	setkeybind Home beginning-of-line
	setkeybind End end-of-line
	setkeybind Insert overwrite-mode
	setkeybind Delete delete-char
	setkeybind Up up-line-or-history
	setkeybind Down down-line-or-history
	setkeybind Left backward-char
	setkeybind Right forward-char
	setkeybind PageUp history-beginning-search-backward
	setkeybind PageDown history-beginning-search-forward
else
	echo "zkbd file missing for $TERM"
fi

setopt notify    # immediate job notifications

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=${HISTFILE:-$HOME/.zsh_history}
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space

# Menu Completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select

source ~/.profile
