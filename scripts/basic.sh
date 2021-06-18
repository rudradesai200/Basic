#!/bin/bash

DJANGOADMIN=$(which django-admin)
GREEN='\033[0;32m'
RED='\033[0;101m'
NC='\033[0m'
bold=$(tput bold)
normal=$(tput sgr0)

if [ $1 == "project" ]
then
    $BASIC_DIR/scripts/project.sh $@
else
	if [ $1 == "app" ]
	then
        $BASIC_DIR/scripts/app.sh $@
    else
        if [ $1 == "auth" ]
        then
            $BASIC_DIR/scripts/auth.sh $@
        else
            if [ $1 == "uninstall" ]
            then
                $BASIC_DIR/uninstall.sh $@
            else
                echo "BASIC : An automated tool for hassle-free Django project setup"
                echo ""
                echo "usage:"
                echo "      project <project_name>  : Creates a project in the current directory"
                echo "      app <app_name>          : Adds an app in the current project"
                echo "      auth                    : Sets up the auth module in the current project"
                echo "      uninstall               : Uninstalls Basic"
            fi
        fi
	fi
fi
