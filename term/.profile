# Add .scripts to PATH
export PATH=$PATH:~/.scripts
# Add zephyr SDK arm eabi toolchain path
export PATH=$PATH:/opt/zephyr-sdk/sysroots/x86_64-pokysdk-linux/usr/bin/arm-zephyr-eabi
# Add pip install path
export PATH=~/.local/bin:$PATH

# Aliases
alias zephyr-env=". src-zephyr"
# If vim is missing clipboard support use vimx instead
if [ "`vim --version | grep +clipboard`" = "" ]; then
alias vi='vimx'
alias vim='vimx'
fi
# zsh
# Colorize
alias cat="ccat"

# Execute scripts
mount_geosatis
