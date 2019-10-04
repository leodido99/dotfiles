# Add .scripts to PATH
export PATH=$PATH:~/.scripts
# Add pip install path
export PATH=~/.local/bin:$PATH
# Set JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/java-11

# Aliases
alias zephyr-env=". src-zephyr"
alias esp32-env=". src-esp32"
# If vim is missing clipboard support use vimx instead
if [ "`vim --version | grep +clipboard`" = "" ]; then
alias vi='vimx'
alias vim='vimx'
fi
alias urxvt='urxvt-ml'
# zsh

# Execute scripts
#mount_geosatis
