# Add .scripts to PATH
export PATH=$PATH:~/.scripts
# Add zephyr SDK arm eabi toolchain path
export PATH=$PATH:/opt/zephyr-sdk/sysroots/x86_64-pokysdk-linux/usr/bin/arm-zephyr-eabi
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
# zsh

# Execute scripts
#mount_geosatis
