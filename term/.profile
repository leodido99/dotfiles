# Add .scripts to PATH
export PATH=$PATH:~/.scripts
# Add zephyr SDK arm eabi toolchain path
export PATH=$PATH:/opt/zephyr-sdk/sysroots/x86_64-pokysdk-linux/usr/bin/arm-zephyr-eabi
# Add pip install path
export PATH=~/.local/bin:$PATH
# Set JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.2.7-0.fc29.x86_64

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
#mount_geosatis
