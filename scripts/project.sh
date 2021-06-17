#!/bin/bash

DJANGOADMIN=$(which django-admin)
GREEN='\033[0;32m'
RED='\033[0;101m'
NC='\033[0m'
bold=$(tput bold)
normal=$(tput sgr0)

PROJECTNAME=$2
$DJANGOADMIN startproject $PROJECTNAME
if [ $? -eq 0 ]; then
    echo -e "Create new project named $PROJECTNAME ... ${GREEN}${bold}OK${normal}${NC}"
else
    echo -e "${RED}${bold}Django Admin installation issues found${normal}${NC}"
    echo -e "${RED}${bold}Please check your installation${normal}${NC}"
    exit 3
fi

# Set up settings.py in project folder
echo "if settings.DEBUG:" >> $PROJECTNAME/$PROJECTNAME/urls.py
echo "  urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)" >> $PROJECTNAME/$PROJECTNAME/urls.py
echo -e "Set up media and static roots in urls ... ${GREEN}${bold}OK${normal}${NC}"

# Set up secret folder
mkdir $PROJECTNAME/secret/
touch $PROJECTNAME/secret/__init__.py
cp $BASIC_DIR/adders/addsettings.py $PROJECTNAME/secret/
echo -e "Create a folder named secret to keep sensitive data ... ${GREEN}${bold}OK${normal}${NC}"

# Set up other directories
mkdir $PROJECTNAME/static
mkdir $PROJECTNAME/media
echo -e "Setup other required directories ... ${GREEN}${bold}OK${normal}${NC}"

# Sets up settings.py for secret folder
$BASIC_DIR/scripts/settings_setup.sh $PROJECTNAME
echo -e "Setup secret folder and setup.py ... ${GREEN}${bold}OK${normal}${NC}"

# Adding gitignore to the folder
cp $BASIC_DIR/adders/.gitignore $PROJECTNAME/
echo -e "Add gitignore to the folder path ... ${GREEN}${bold}OK${normal}${NC}"

# Migrating changes to db
$BASICPYTHONPATH $PROJECTNAME/manage.py makemigrations
$BASICPYTHONPATH $PROJECTNAME/manage.py migrate
echo -e "Migrate changes ... ${GREEN}${bold}OK${normal}${NC}"

echo -e "Project Setup complete ... ${GREEN}${bold}OK${normal}${NC}"