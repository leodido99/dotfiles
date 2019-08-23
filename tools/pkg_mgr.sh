#!/usr/bin/bash
# Determine which package manager to use
MGRS=( dnf apt-get brew yum )

for MGR in "${MGRS[@]}"; do
	EXISTS=$(which $MGR)
	if [[ ! -z $EXISTS ]]; then
		MGRFOUND=$MGR
		break
	fi
done

if [ -z $MGRFOUND ]; then
	echo "Cannot find package manager"
	exit 1
fi

if [ $MGRFOUND = "dnf" ] || [ $MGRFOUND = "brew" ] || [ $MGRFOUND = "yum" ]; then
	INSTALLCMD="$MGRFOUND install "
fi
