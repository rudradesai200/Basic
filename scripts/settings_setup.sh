#!/bin/bash
PROJECTNAME=$1
APPNAME=$2
SETTINGS=$PROJECTNAME/$PROJECTNAME/settings.py

# adding imports

if grep 'from' $SETTINGS &> /dev/null
then
    sed -i 's/from/import os\nfrom secret import addsettings\nfrom/g' $SETTINGS
else
    if grep 'import os' $SETTINGS &> /dev/null
    then
        sed -i 's/import os/from secret import addsettings\nimport os/g' $SETTINGS
    else
        if grep 'import' $SETTINGS &> /dev/null
        then
            sed -i 's/import/from secret import addsettings\nimport os\nimport/g' $SETTINGS
        else
            echo "SETUP FAILED"
        fi
    fi
fi 

# remove debug=True and allowed host
sed -i 's/DEBUG.*/DEBUG = addsettings.DEBUG /g' $SETTINGS
sed -i 's/ALLOWED_HOSTS.*/ALLOWED_HOSTS = addsettings.ALLOWED_HOSTS /g' $SETTINGS

# Change databases in settings
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/DATABASES\([^\n]*\n\)\{6\}/DATABASES = addsettings.DATABASES /g" $SETTINGS

# Add static url and media urls and other settings
cat $BASIC_DIR/adders/settings_adders.txt >> $SETTINGS

# Extracting Key from settings.py
SECRET_KEY=$(grep -o "SECRET_KEY = '.*'" $SETTINGS)
sed -i "s/SECRET_KEY.*/SECRET_KEY = addsettings.SECRET_KEY/g" $SETTINGS

# Storing the key in secret/addsettings.py
sed -i "s/SECRET_KEY=\"\"/$SECRET_KEY/g" $PROJECTNAME/secret/addsettings.py

# Updating imports of urls.py
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/from django.contrib import admin\nfrom django.urls import path/from django.contrib import admin\nfrom django.urls import path,include\nfrom django.conf import settings\nfrom django.conf.urls.static import static\n/g" $PROJECTNAME/$PROJECTNAME/urls.py