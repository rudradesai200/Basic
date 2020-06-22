# BASIC : A basic package for advanced Django Setup
A advanced package for complete setup of Django-Python framework. Most of the features setup are covered like templatetags, Django-admin custom commands, includes and templating in django. Just install this package, use the setup script for setup and then use it to have a preconfigured advanced django project with just one command. Also, add as many apps you want, with no additional setup to be done. Everything like adding urls , including that app to INCLUDED_APPS, setting up basic index page etc is done automatically . Currently, only python3 and Django>=2.2 are supported. Please look at the examples below to start

## GET STARTED
##### Setup
```
git clone https://github.com/rudradesai200/Basic.git
cd basic/
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
