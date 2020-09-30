#!/usr/bin/env bash
set -e

SDK_VER="0.10.0"
GEOGITREPO="$HOME/gitrepo/fwv6"
RELEASEJSON="geosatis/fw6_release_dev.json"
FES_TESTPORT="9092"
FES_RAGESPORT="8082"
FES_PORT=$FES_TESTPORT

if [ "$#" -lt 4 ]; then
	echo "Usage $0 <git branch> <board> <hw version> <fw type> [-fes1]"
	exit 1
fi

GITBRANCH=$1
BOARD=$2
HWVERSION=$3
FWTYPE=$4

echo "Pushing $GITBRANCH/$FWTYPE for ${BOARD}_v$HWVERSION"

if [ "$6" == "-fes1" ]; then
	echo "!!!!! PUSHING TO RAGES FES !!!!!"
	read -p "Press a key"
	FES_PORT=$FES_RAGESPORT
fi

cd $GEOGITREPO
. src-zephyr $SDK_VER

git co $GITBRANCH

./geosatis/fw6_release.py --board ${BOARD} --json ${RELEASEJSON} --name ${FWTYPE} --hw ${HWVERSION} --wrap ~/backup_stuff/fes/fbs_dir --wrap_name ${FWTYPE}.zip --sign fake_fbs --enc FakeARCA --no-check

./geosatis/fss_dev.sh app_0 ~/backup_stuff/fes/fbs_dir/${FWTYPE}.zip.gpg ~/backup_stuff/fes/fss_dir/${FWTYPE}.zip.gpg fake_fbs FakeARCA fes@geo-satis.com

cd ~/backup_stuff/fes
curl -v --cacert ~/backup_stuff/fes/fes-tls-upload-cert.pem --cert my_fes_certificate.pem --key my_fes_key.pem https://gstfes:${FES_PORT}/ -F "data=@/home/lbise/backup_stuff/fes/fss_dir/${FWTYPE}.zip.gpg"

cd $GEOGITREPO
