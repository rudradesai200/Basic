#!/bin/bash

DJANGOADMIN=$(which django-admin)
GREEN='\033[0;32m'
RED='\033[0;101m'
NC='\033[0m' # No Color
bold=$(tput bold)
normal=$(tput sgr0)

if [ $1 == "project" ]
then
    PROJECTNAME=$2
	$DJANGOADMIN startproject $PROJECTNAME
    if [ $? -eq 0 ]; then
        echo -e "A new Django Project created with name $PROJECTNAME ... ${GREEN}${bold}OK${normal}${NC}"
    else
        echo -e "${RED}${bold}Django Admin installation issues found${normal}${NC}"
        echo -e "${RED}${bold}Please check your installation${normal}${NC}"
        exit 3
    fi

    # Set up settings.py in project folder
    echo "if settings.DEBUG:" >> $PROJECTNAME/urls.py
    echo "  urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)" >> $PROJECTNAME/urls.py
    echo -e "Set up media and static roots in urls ... ${GREEN}${bold}OK${normal}${NC}"

    # Set up secret folder
    mkdir $PROJECTNAME/secret/
    touch $PROJECTNAME/secret/__init__.py
    cp $BASIC_DIR/adders/addsettings.py $PROJECTNAME/secret/
    echo -e "Created a folder named secret to keep sensitive data ... ${GREEN}${bold}OK${normal}${NC}"

    # Set up other directories
	mkdir $PROJECTNAME/static
	mkdir $PROJECTNAME/media
    echo -e "Setup other required directories ... ${GREEN}${bold}OK${normal}${NC}"

    # Sets up settings.py for secret folder
    $BASIC_DIR/scripts/settings_setup.sh $PROJECTNAME
    echo -e "Setup secret folder used and transfered variables ... ${GREEN}${bold}OK${normal}${NC}"

    # Adding gitignore to the folder
    cp $BASIC_DIR/adders/.gitignore $PROJECTNAME/
    echo -e "Adding gitignore to the folder path ... ${GREEN}${bold}OK${normal}${NC}"
    
    # Migrating changes to db
    $BASICPYTHONPATH $PROJECTNAME/manage.py makemigrations
    $BASICPYTHONPATH $PROJECTNAME/manage.py migrate
    echo -e "Changes migrated ... ${GREEN}${bold}OK${normal}${NC}"

	echo -e "Project Setup complete ... ${GREEN}${bold}OK${normal}${NC}"
else
	if [ $1 == "app" ]
	then
        # Gettings variables
        APPNAME=$2
        PROJECTDIR=$(find . -name "settings.py" )
        PROJECTNAME=$(echo $PROJECTDIR | cut -d'/' -f 2)

		$BASICPYTHONPATH manage.py startapp $APPNAME
        if [ $? -eq 0 ]; then
            echo -e "A new app with name $APPNAME created ... ${GREEN}${bold}OK${normal}${NC}"
        else
            echo -e "${RED}${bold} Manage.py file not found ${normal}${NC}"
            echo -e "${RED}${bold} Please run this command from your django project directory ${normal}${NC}"
            exit 5
        fi

		# Sets up remaining files in the app
		touch $APPNAME/forms.py
		cp $BASIC_DIR/adders/urls.py $APPNAME/
        sed -i -e ':a' -e 'N' -e '$!ba' -e "s/|APPNAME|/$APPNAME/g" $APPNAME/urls.py
        echo -e "Created other required files ... ${GREEN}${bold}OK${normal}${NC}"

		# Sets up templates and templates tags
		mkdir $APPNAME/templates
		cp $BASIC_DIR/templates/* $APPNAME/templates/ -r
		mkdir $APPNAME/templatetags/
		touch $APPNAME/templatetags/__init__.py
		sed -i "s/|APPNAME|/$APPNAME/g" $APPNAME/templates/base.html
        sed -i "s/|PAGENAME|/Index/g" $APPNAME/templates/index.html
		echo -e "Created templates dirs and templates ... ${GREEN}${bold}OK${normal}${NC}"

		# Sets up management for manual manage.py commands
		mkdir $APPNAME/management
		mkdir $APPNAME/management/commands
		touch $APPNAME/management/commands/_private.py
        echo -e "Set up management for manual manage.py commands ... ${GREEN}${bold}OK${normal}${NC}"

		# Sets up assets and upload folders
		mkdir static/$APPNAME
		mkdir media/$APPNAME
		mkdir static/$APPNAME/css
		mkdir static/$APPNAME/js
		mkdir static/$APPNAME/images
		cp $BASIC_DIR/assets/* static/$APPNAME/ -r
        echo -e "Set up static and media folders ... ${GREEN}${bold}OK${normal}${NC}"

		# Adding app name to INSTALLED_APPS
        sed -i -e ':a' -e 'N' -e '$!ba' -e "s/INSTALLED_APPS\([^]]*\n*\)*/&\t\'$APPNAME\',\n/g" ./$PROJECTNAME/settings.py
        echo -e "Added this app into INSTALLED_APPS ... ${GREEN}${bold}OK${normal}${NC}"

        # Set up urls.py in project folder
        sed -i "s/urlpatterns = \[/urlpatterns = \[\n\tpath\(\'$APPNAME\', include\(\'$APPNAME\.urls\'\), name=\"$APPNAME\_urls\"\),/g" $PROJECTNAME/urls.py
        echo -e "Added urls for $APPNAME to project's urls.py ... ${GREEN}${bold}OK${normal}${NC}"

        #Set up views.py in app's folder
        echo "def index(request):" >> $APPNAME/views.py
        echo "  return render(request,\"index.html\")" >> $APPNAME/views.py
        echo -e "Set up views.py ... ${GREEN}${bold}OK${normal}${NC}"

        echo -e "App setup done ... ${GREEN}${bold}OK${normal}${NC}"
	fi
fi
