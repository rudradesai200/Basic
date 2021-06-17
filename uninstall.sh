#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;101m'
NC='\033[0m'
bold=$(tput bold)
normal=$(tput sgr0)

echo "A Big Thanks for using BASIC!"
echo "Please share your review with rudrad200@gmail.com"
echo ""

echo -n "Do you want to remove the installation files? [y|N]" && read option
if [ "$option" == "y" ]
then
    rm -rf $BASIC_DIR
    if [ $? -eq 0 ]
    then
        echo -e "${GREEN}Installation files removed${NC}"
    else
        echo -e "${RED}Remove failed${NC}"
        echo -e "Please manually remove ${bold}$BASIC_DIR${normal} directory"
    fi
fi

echo -n "Enter your default shell ($SHELL) : " && read shell
if [ -z "$shell" ]
then
    SHELL=$SHELL
else
    SHELL=$shell
fi

SHELLRC=~/.$(echo $SHELL | grep -Po '(?<=/usr/bin/)(.+)')rc
echo "SHELLRC: $SHELLRC"

sed -i '/BASIC.*/d' $SHELLRC

if [ $? -eq 0 ]
then
    echo -e "${GREEN}Uninstall successful${NC}"
else
    echo -e "${RED}Uninstall failed${NC}"
    echo -e "Please manually remove all the lines containing ${bold}'### BASIC ###'${normal} from ${bold}$SHELLRC${normal}"
fi
