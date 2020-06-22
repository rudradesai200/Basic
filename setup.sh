#!/bin/bash
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
    echo "Python version > 2.7.0 OK"
else
    echo "Please install Python3 before proceeding"
    exit 1
fi

echo "Checking for django-admin installation"
if which django-admin &> /dev/null; then
    echo "django-admin installation found OK"
else
    echo 'django-admin not found'
    echo 'Installing Django'
    echo -n "Enter you Pip3 Path ($(which pip3)) : " && read pippath
    if [ -z "$pippath" ]
    then
        BASICPIPPATH=$(which pip3)
    else
        BASICPIPPATH=$pippath
    fi
    echo "sudo $BASICPIPPATH install Django"
    sudo -m $BASICPIPPATH install Django
fi

echo "Checking for django version"
djangover=$(django-admin version)
requiredver=2.2
if [ $djangoover >= $requiredver ]
then
    echo "Django version >= 2.2 OK"
else
    echo "Django version $djangover"
    echo "Please install Django version >= 2.2 for this script to work"
    exit 2
fi

BASIC_DIR=$(pwd)
echo "export BASIC_DIR=\"$BASIC_DIR\"" >> ~/.bashrc

chmod +x $BASIC_DIR/scripts/basic.sh
chmod +x $BASIC_DIR/scripts/settings_setup.sh

echo "alias basic=\"$BASIC_DIR/scripts/basic.sh\"" >> ~/.bashrc