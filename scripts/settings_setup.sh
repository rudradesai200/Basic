#!/bin/bash
PROJECTNAME=$1
APPNAME=$2

# remove debug=True and allowed host
sed -i 's/DEBUG.*/DEBUG = addsettings.DEBUG /g' $PROJECTNAME/$PROJECTNAME/settings.py
sed -i 's/ALLOWED_HOSTS.*/ALLOWED_HOSTS = addsettings.ALLOWED_HOSTS /g' $PROJECTNAME/$PROJECTNAME/settings.py

# Change databases in settings
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/DATABASES\([^\n]*\n\)\{6\}/DATABASES = addsettings.DATABASES /g" $PROJECTNAME/$PROJECTNAME/settings.py

# adding imports
sed -i 's/import os/import os\nfrom secret import addsettings /g' $PROJECTNAME/$PROJECTNAME/settings.py

# Add static url and media urls and other settings
cat ~/basic/adders/settings_adders.txt >> $PROJECTNAME/$PROJECTNAME/settings.py

# Extracting Key from settings.py
SECRET_KEY=$(grep -o "SECRET_KEY = '.*'" $PROJECTNAME/$PROJECTNAME/settings.py)
sed -i "s/SECRET_KEY.*/SECRET_KEY = addsettings.SECRET_KEY/g" $PROJECTNAME/$PROJECTNAME/settings.py

# Storing the key in secret/addsettings.py
sed -i "s/SECRET_KEY=\"\"/$SECRET_KEY/g" $PROJECTNAME/secret/addsettings.py

# Updating imports of urls.py
sed -i -e ':a' -e 'N' -e '$!ba' -e "s/from django.contrib import admin\nfrom django.urls import path/from django.contrib import admin\nfrom django.urls import path,include\nfrom django.conf import settings\nfrom django.conf.urls.static import static\n/g" $PROJECTNAME/$PROJECTNAME/urls.py