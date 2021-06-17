#!/bin/bash

DJANGOADMIN=$(which django-admin)
GREEN='\033[0;32m'
RED='\033[0;101m'
NC='\033[0m'
bold=$(tput bold)
normal=$(tput sgr0)

APPNAME="accounts"
PROJECTDIR=$(find . -name "settings.py" )
PROJECTNAME=$(echo $PROJECTDIR | cut -d'/' -f 2)

cp $BASIC_DIR/adders/accounts . -r
if [ $? -eq 0 ]; then
    echo -e "Create a new app named $APPNAME ... ${GREEN}${bold}OK${normal}${NC}"
else
    echo -e "${RED}${bold} Manage.py file not found ${normal}${NC}"
    echo -e "${RED}${bold} Please run this command from your django project directory ${normal}${NC}"
    exit 5
fi

# Sets up assets and upload folders
mkdir $APPNAME/static/
mkdir $APPNAME/media/
mkdir $APPNAME/static/$APPNAME
mkdir $APPNAME/media/$APPNAME
mkdir $APPNAME/static/$APPNAME/css
mkdir $APPNAME/static/$APPNAME/js
mkdir $APPNAME/static/$APPNAME/images
cp $BASIC_DIR/assets/* static/$APPNAME/ -r
echo -e "Set up static and media folders ... ${GREEN}${bold}OK${normal}${NC}"

# Adding app name to INSTALLED_APPS
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/INSTALLED_APPS\([^]]*\n*\)*/&\t\'$APPNAME\',\n/g" ./$PROJECTNAME/settings.py
echo -e "Add this app into INSTALLED_APPS ... ${GREEN}${bold}OK${normal}${NC}"

# Adding URLs in settings.py
echo "LOGIN_URL = \"accounts/login/\"" >> $PROJECTNAME/settings.py
echo "LOGIN_REDIRECT_URL = \"accounts/\"" >> $PROJECTNAME/settings.py
echo "LOGOUT_REDIRECT_URL = \"accounts/\"" >> $PROJECTNAME/settings.py
echo -e "Add URLS for easy access in settings.py ... ${GREEN}${bold}OK${normal}${NC} "

# Set up urls.py in project folder
sed -i "s/urlpatterns = \[/urlpatterns = \[\n\tpath\(\'$APPNAME\/\', include\(\'$APPNAME\.urls\'\), name=\"$APPNAME\_urls\"\),/g" $PROJECTNAME/urls.py
echo -e "Add urls for $APPNAME to project's urls.py ... ${GREEN}${bold}OK${normal}${NC}"

echo -e "App setup done ... ${GREEN}${bold}OK${normal}${NC}"