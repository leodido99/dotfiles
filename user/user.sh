#!/usr/bin/env bash
# Setup user

# Get script's dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

if [ $1 = "Ubuntu" ] || [ $1 = "Fedora" ]; then
	# Access tty dev
	usermod -a -G dialout $USER
fi
