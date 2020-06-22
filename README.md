# BASIC : An advanced autmated environment setup for Django.
An advanced package for the complete setup of the Django-Python framework. Installation of most of the features is covered like template tags, Django-admin custom commands, include and templating in Django. Just install this package, use the setup script for setup and then use it to have a preconfigured advanced Django project with only one command. 

Also, add as many apps you want, with no additional configuration to be done. Everything like adding URLs, including that app to INCLUDED_APPS, setting up the basic index page, and many more, is done automatically. Currently, only python3 and Django>=2.2 are supported. Please look at the examples below to start.

## GET STARTED
##### Setup
```
git clone https://github.com/rudradesai200/Basic.git
cd Basic/
chmod +x setup.sh
./setup.sh
source ~/.bashrc
```
##### USE
```
basic project <projectname> # it will create a django project with name <projectname>
cd <projectname>
basic app <appname> # it will create an app with the name <appname>
```
That's it, a complete django project will be setup. It includes app and other settings too. Please explore the files created to know more.
