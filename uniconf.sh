#!/bin/bash
# Tool for manipulate Unifi advanced condifuration in JSON

COMMAND=$1
SSHCONN=$2
SITEPATH=/usr/lib/unifi/data/default

if [ -z $3 ]; then
	CONFIGFILE=$3
else
	CONFIGFILE=config.gateway.json
fi

case $COMMAND in 
	getconf)
		ssh $SSHCONN "mca-ctrl -t dump-cfg" > $CONFIGFILE
		;;
	pushconf)
		scp $CONFIGFILE $SSHCONN:
		ssh $SSHCONN "sudo cp $CONFIGFILE $SITEPATH && sudo chown unifi.unifi $SITEPATH/$CONFIGFILE && sudo chmod 640 $SITEPATH/CONFIGFILE"
		;;
	*)
		echo "Uknown command"
		;;
esac

