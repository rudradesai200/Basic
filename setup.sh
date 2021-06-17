#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;101m'
NC='\033[0m'
bold=$(tput bold)
normal=$(tput sgr0)

echo -n "Enter your default shell ($SHELL) : " && read shell
if [ -z "$shell" ]
then
    SHELL=$SHELL
else
    SHELL=$shell
fi

SHELLRC=~/.$(echo $SHELL | grep -Po '(?<=/usr/bin/)(.+)')rc
echo "SHELLRC: $SHELLRC"

echo -n "Enter you Python3 Path ($(which python3)) : " && read pythonpath
if [ -z "$pythonpath" ]
then
	BASICPYTHONPATH=$(which python3)
else
	BASICPYTHONPATH=$pythonpath
fi
echo "PYTHONPATH: $BASICPYTHONPATH"

echo "" >> $SHELLRC
echo "### BASIC app path variables ###" >> $SHELLRC
echo "export BASICPYTHONPATH=\"$BASICPYTHONPATH\" ### BASIC ###" >> $SHELLRC

echo "Checking python version"
version=$($BASICPYTHONPATH -V 2>&1 | grep -Po '(?<=Python )(.+)')
parsedVersion=$(echo "${version//./}")
if [ "$parsedVersion" -gt "270" ]
then 
    echo -e "Python version > 2.7.0 .... ${GREEN}${bold}OK${normal}${NC}"
else
    echo -e "${RED}${bold}Please install Python3 before proceeding${normal}${NC}"
    exit 1
fi

echo "Checking for django-admin installation"
if which django-admin &> /dev/null; then
    echo -e "django-admin installation found .... ${GREEN}${bold}OK${normal}${NC}"
else
    echo -e "${RED}${bold}django-admin not found${normal}${NC}"
    echo 'Installing Django'
    if [ which pip3 &> /dev/null ] ; then
        check=$(which pip)
    else
        check=$(which pip3)
    fi
    echo -n "Enter you Pip3 Path ($check) : " && read pippath
    if [ -z "$pippath" ]
    then
        BASICPIPPATH=$check
    else
        BASICPIPPATH=$pippath
    fi
    echo "$BASICPIPPATH install Django --no-cache-dir"
    $BASICPIPPATH install Django --no-cache-dir
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Successfully Installed Django${NC}"
    else
        echo -e "${RED}${bold}Please manually install Django${normal}${NC}"
        echo -e "${RED}${bold}And run this script again${normal}${NC}"
        exit 4
    fi
fi

echo "Checking for django version"
djangover=$(django-admin version)
requiredver=2.2
if [ $djangoover >= $requiredver ]
then
    echo -e "Django version >= 2.2 ..... ${GREEN}${bold}OK${normal}${NC}"
else
    echo "Django version $djangover"
    echo -e "${RED}${bold}Please install Django version >= 2.2 for this script to work${normal}${NC}"
    exit 2
fi

BASIC_DIR=$(pwd)
echo "export BASIC_DIR=\"$BASIC_DIR\" ### BASIC ###" >> $SHELLRC

chmod +x $BASIC_DIR/scripts/basic.sh
chmod +x $BASIC_DIR/scripts/settings_setup.sh

echo "alias basic=\"$BASIC_DIR/scripts/basic.sh\" ### BASIC ###" >> $SHELLRC

echo "### BASIC app path variables end ###" >> $SHELLRC
echo "" >> $SHELLRC

rm -f '='