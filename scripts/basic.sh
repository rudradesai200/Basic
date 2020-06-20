#!/bin/bash
if [ $1 == "project" ]
then
    PROJECTNAME=$2
	django-admin startproject $PROJECTNAME
	echo "A new Django Project created with name $PROJECTNAME"

    # Set up settings.py in project folder
    echo "if settings.DEBUG:" >> $PROJECTNAME/urls.py
    echo "  urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)" >> $PROJECTNAME/urls.py
    echo "Set up media and static roots in urls"

    # Set up secret folder
    mkdir $PROJECTNAME/secret/
    touch $PROJECTNAME/secret/__init__.py
    cp $BASIC_DIR/adders/addsettings.py $PROJECTNAME/secret/
    echo "Created a folder named secret to keep sensitive data"

    # Set up other directories
	mkdir $PROJECTNAME/static
	mkdir $PROJECTNAME/media
    echo "Setup other required directories"

    # Sets up settings.py for secret folder
    $BASIC_DIR/scripts/settings_setup.sh $PROJECTNAME
    echo "Setup secret folder used and transfered variables"

    # Adding gitignore to the folder
    cp $BASIC_DIR/adders/.gitignore $PROJECTNAME/
    echo "Adding gitignore to the folder path"
    
    # Migrating changes to db
    python3 $PROJECTNAME/manage.py makemigrations
    python3 $PROJECTNAME/manage.py migrate
    echo "Changes migrated"

	echo "Project Setup complete"
else
	if [ $1 == "app" ]
	then
        # Gettings variables
        APPNAME=$2
        PROJECTDIR=$(find . -name "settings.py" )
        PROJECTNAME=$(echo $PROJECTDIR | cut -d'/' -f 2)

		python3 manage.py startapp $APPNAME
		echo "A new app with name $APPNAME created"

		# Sets up remaining files in the app
		touch $APPNAME/forms.py
		cp $BASIC_DIR/adders/urls.py $APPNAME/
        sed -i -e ':a' -e 'N' -e '$!ba' -e "s/|APPNAME|/$APPNAME/g" $APPNAME/urls.py
        echo "Created other required files"

		# Sets up templates and templates tags
		mkdir $APPNAME/templates
		cp $BASIC_DIR/templates/* $APPNAME/templates/ -r
		mkdir $APPNAME/templatetags/
		touch $APPNAME/templatetags/__init__.py
		sed -i "s/|APPNAME|/$APPNAME/g" $APPNAME/templates/base.html
        sed -i "s/|PAGENAME|/Index/g" $APPNAME/templates/index.html
		echo "Created templates dirs and templates"

		# Sets up management for manual manage.py commands
		mkdir $APPNAME/management
		mkdir $APPNAME/management/commands
		touch $APPNAME/management/commands/_private.py
        echo "Set up management for manual manage.py commands"

		# Sets up assets and upload folders
		mkdir static/$APPNAME
		mkdir media/$APPNAME
		mkdir static/$APPNAME/css
		mkdir static/$APPNAME/js
		mkdir static/$APPNAME/images
		cp $BASIC_DIR/assets/* static/$APPNAME/ -r
        echo "Set up static and media folders"

		# Adding app name to INSTALLED_APPS
        sed -i -e ':a' -e 'N' -e '$!ba' -e "s/INSTALLED_APPS\([^]]*\n*\)*/&\t\'$APPNAME\',\n/g" ./$PROJECTNAME/settings.py
        echo "Added this app into INSTALLED_APPS"

        # Set up urls.py in project folder
        sed -i "s/urlpatterns = \[/urlpatterns = \[\n\tpath\(\'$APPNAME\', include\(\'$APPNAME\.urls\'\), name=\"$APPNAME\_urls\"\),/g" $PROJECTNAME/urls.py
        echo "Added urls for $APPNAME to project's urls.py"

        #Set up views.py in app's folder
        echo "def index(request):" >> $APPNAME/views.py
        echo "  return render(request,\"index.html\")" >> $APPNAME/views.py
        echo "Set up views.py"

        echo "App setup done"
	fi
fi
