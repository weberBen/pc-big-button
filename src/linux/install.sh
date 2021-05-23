#!/bin/bash

if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

#-------------------------------------------------------------------------

BASE_DIR_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source "$BASE_DIR_SCRIPT/helpers"


echo "" > $UDEV_RULE #helpers variable
groupadd $UDEV_GROUP #helpers variable
usermod -a -G $UDEV_GROUP $SUDO_USER

INSTALL_DIR="/usr/local/lib"
read  -n 1 -p "Default installation directory is '$INSTALL_DIR'. Change it ?  [y/n] ? `echo $'\n> '`" resp
echo 

if [[ $resp == "y" ]]; then
    read -p "Enter an installation directory : " path
    while [[ ! -d $path ]]; 
    do
        echo "  Invalid directory"
        read -p "Enter an installation directory : " path
    done
    INSTALL_DIR="${path%/}"
fi

DIR_NAME="bigButton"

cp -r "$BASE_DIR_SCRIPT" "$INSTALL_DIR/$DIR_NAME"

for file in $(find "$INSTALL_DIR/$DIR_NAME")
do
    [[ ! -f $file ]] && continue
    [[ "$(head -n 1 $file)" != "#!/bin/bash" ]] && continue;
    chmod +x $file
done

echo -e "#!/bin/bash \n
$INSTALL_DIR/$DIR_NAME/bigButton \$@ \n
" > /usr/local/bin/bigbutton
chmod +x /usr/local/bin/bigbutton

$INSTALL_DIR/$DIR_NAME/configurator


echo " "
echo "--------------"
echo " "
echo "Installation is done ! You need to restart your computer"
