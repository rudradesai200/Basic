# BASIC : An advanced automated environment setup for the Django-Python Frameword.
An advanced package for the complete setup of the Django-Python framework. Installation of most of the features is covered like template tags, Django-admin custom commands, include and templating in Django. Just install this package, use the setup script for setup and then use it to have a preconfigured advanced Django project with only one command. 

Also, add as many apps you want, with no additional configuration to be done. Everything like adding URLs, including that app to INCLUDED_APPS, setting up the basic index page, and many more, is done automatically. Please look at the examples below to start.
### NOTE:  Currently, It can be run on Linux machines only. And only Python==3 and Django>=2.2 are supported
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
##### Examples
```
basic project newproject
```
![project_setup](https://user-images.githubusercontent.com/44108388/85259975-92851000-b487-11ea-8933-cec4c8b2919b.png)

```
cd newproject
basic app first
```
![app_setup](https://user-images.githubusercontent.com/44108388/85259979-944ed380-b487-11ea-94b8-e4d05d83bbb9.png)

That's it, a complete django project will be setup. It includes app and other settings too. Please explore the files created to know more.
