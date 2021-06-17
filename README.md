# BASIC : An automated tool for hassle-free Django project setup
'Basic' is a complete package for the advanced setup of the Django-Python framework. Setup of most of the features including and not limited to template tags, Django-admin custom commands, include and templating in Django are covered. Just install this package, run the setup script, and then use it to have your own preconfigured advanced Django project with just a few commands. 

Also, add as many apps you want, with no additional configuration to be done. Everything like adding URLs, including that app to INCLUDED_APPS, setting up the basic index page, and many more, is done automatically. Please look at the examples below to get started.

A complete authentication system can be set up with just one command. Login, Logout & Register functionalities are already supported and can be extended to many more.

### NOTE:  It can be run on any Linux machine with Python>=3 and Django>=2.2.
## GET STARTED
##### Setup
```
git clone https://github.com/rudradesai200/Basic.git
cd Basic/
chmod +x setup.sh
chmod +x uninstall.sh
./setup.sh
source ~/.bashrc # OR other default shell
```

##### Uninstall
```
$BASIC_DIR/uninstall.sh
# Restart the terminal to remove the alias and env variables
```

##### USE
Go to your Desktop or other directory except the installation one.
```
basic project <projectname> # it will create a django project with name <projectname>
cd <projectname>
basic app <appname> # it will create an app with the name <appname>
                    # All the paths, fields and folders will be setup automatically
basic authenitcate  # it will create an app named "accounts" which can be used for authentication purposes
                    # it contains functinalities like login, logout, register
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

```
python3 manage.py runserver
```
![website](https://user-images.githubusercontent.com/44108388/85263979-9fa4fd80-b48d-11ea-86de-13e3b819694e.png)

```
basic authenticate
```
![website](https://user-images.githubusercontent.com/44108388/101983345-9197a300-3ca0-11eb-8dc4-2fcc0f471548.png)

This command can be used to create a basic authentication app named accounts.
It supports login, logout and register functionalities. Other functinalities can be added easily.

That's it, a complete django project will be setup. It includes app and other settings too. Please explore the files created to know more.
