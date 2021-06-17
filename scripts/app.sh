#!/bin/bash

DJANGOADMIN=$(which django-admin)
GREEN='\033[0;32m'
RED='\033[0;101m'
NC='\033[0m'
bold=$(tput bold)
normal=$(tput sgr0)

# Gettings variables
APPNAME=$2
PROJECTDIR=$(find . -name "settings.py" )
PROJECTNAME=$(echo $PROJECTDIR | cut -d'/' -f 2)

$BASICPYTHONPATH manage.py startapp $APPNAME
if [ $? -eq 0 ]; then
    echo -e "Create a new app named $APPNAME ... ${GREEN}${bold}OK${normal}${NC}"
else
    echo -e "${RED}${bold} Manage.py file not found ${normal}${NC}"
    echo -e "${RED}${bold} Please run this command from your django project directory ${normal}${NC}"
    exit 5
fi

# Sets up remaining files in the app
touch $APPNAME/forms.py
cp $BASIC_DIR/adders/urls.py $APPNAME/
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/|APPNAME|/$APPNAME/g" $APPNAME/urls.py
echo -e "Create other required files ... ${GREEN}${bold}OK${normal}${NC}"

# Sets up templates and templates tags
mkdir $APPNAME/templates
mkdir $APPNAME/templates/$APPNAME
cp $BASIC_DIR/templates/* $APPNAME/templates/$APPNAME -r
mkdir $APPNAME/templatetags
mkdir $APPNAME/templatetags/$APPNAME
touch $APPNAME/templatetags/$APPNAME/__init__.py
sed -i "s/|APPNAME|/$APPNAME/g" $APPNAME/templates/$APPNAME/base.html
sed -i "s/|APPNAME|/$APPNAME/g" $APPNAME/templates/$APPNAME/index.html
sed -i "s/|PAGENAME|/Index/g" $APPNAME/templates/$APPNAME/index.html
echo -e "Create templates dirs and templates ... ${GREEN}${bold}OK${normal}${NC}"

# Sets up management for manual manage.py commands
mkdir $APPNAME/management
mkdir $APPNAME/management/commands
touch $APPNAME/management/commands/_private.py
echo -e "Set up management for manual manage.py commands ... ${GREEN}${bold}OK${normal}${NC}"

# Sets up assets and upload folders
mkdir $APPNAME/static/
mkdir $APPNAME/media/
mkdir $APPNAME/static/$APPNAME
mkdir $APPNAME/media/$APPNAME
mkdir $APPNAME/static/$APPNAME/css
mkdir $APPNAME/static/$APPNAME/js
mkdir $APPNAME/static/$APPNAME/images
cp $BASIC_DIR/assets/* $APPNAME/static/$APPNAME/ -r
echo -e "Set up static and media folders ... ${GREEN}${bold}OK${normal}${NC}"

# Adding app name to INSTALLED_APPS
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/INSTALLED_APPS\([^]]*\n*\)*/&\t\'$APPNAME\',\n/g" ./$PROJECTNAME/settings.py
echo -e "Add this app into INSTALLED_APPS ... ${GREEN}${bold}OK${normal}${NC}"

# Set up urls.py in project folder
sed -i "s/urlpatterns = \[/urlpatterns = \[\n\tpath\(\'$APPNAME\/\', include\(\'$APPNAME\.urls\'\), name=\"$APPNAME\_urls\"\),/g" $PROJECTNAME/urls.py
echo -e "Add urls for $APPNAME to project's urls.py ... ${GREEN}${bold}OK${normal}${NC}"

#Set up views.py in app's folder
echo "def index(request):" >> $APPNAME/views.py
echo "  return render(request,\"$APPNAME/index.html\")" >> $APPNAME/views.py
echo -e "Set up views.py ... ${GREEN}${bold}OK${normal}${NC}"

echo -e "App setup done ... ${GREEN}${bold}OK${normal}${NC}"