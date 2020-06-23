#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
echo -n "Enter you Python3 Path ($(which python3)) : " && read pythonpath
if [ -z "$pythonpath" ]
then
	BASICPYTHONPATH=$(which python3)
else
	BASICPYTHONPATH=$pythonpath
fi
echo "PYTHONPATH: $BASICPYTHONPATH"
echo "# BASIC app path variables " >> ~/.bashrc
echo "export BASICPYTHONPATH=\"$BASICPYTHONPATH\"" >> ~/.bashrc

echo "Checking python version"
version=$($BASICPYTHONPATH -V 2>&1 | grep -Po '(?<=Python )(.+)')
parsedVersion=$(echo "${version//./}")
if [ "$parsedVersion" -gt "270" ]
then 
    echo -e "Python version > 2.7.0 .... ${GREEN}OK${NC}"
else
    echo -e "${RED}Please install Python3 before proceeding${NC}"
    exit 1
fi

echo "Checking for django-admin installation"
if which django-admin &> /dev/null; then
    echo -e "django-admin installation found .... ${GREEN}OK${NC}"
else
    echo -e "${RED}django-admin not found${NC}"
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
        echo -e "${RED}Please manually install Django${NC}"
        echo -e "${RED}And run this script again${NC}"
        exit 4
    fi
fi

echo "Checking for django version"
djangover=$(django-admin version)
requiredver=2.2
if [ $djangoover >= $requiredver ]
then
    echo -e "Django version >= 2.2 ..... ${GREEN}OK${NC}"
else
    echo "Django version $djangover"
    echo -e "${RED}Please install Django version >= 2.2 for this script to work${NC}"
    exit 2
fi

BASIC_DIR=$(pwd)
echo "export BASIC_DIR=\"$BASIC_DIR\"" >> ~/.bashrc

chmod +x $BASIC_DIR/scripts/basic.sh
chmod +x $BASIC_DIR/scripts/settings_setup.sh

echo "alias basic=\"$BASIC_DIR/scripts/basic.sh\"" >> ~/.bashrc