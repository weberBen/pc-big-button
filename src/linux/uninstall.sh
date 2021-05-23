#!/bin/bash

if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

#-------------------------------------------------------------------------

BASE_DIR_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source "$BASE_DIR_SCRIPT/helpers"

read -n 1 -p "Remove group '$UDEV_GROUP' ? [y/n] `echo $'\n> '`" resp
if [[ "$resp" == "y" ]]; then
    delgroup $UDEV_GROUP
fi

rm $UDEV_RULE #helpers variable

rm -r "$BASE_DIR_SCRIPT"
rm /usr/local/bin/bigbutton

echo " "
echo "--------------"
echo " "
echo "Uninstallation is done"
