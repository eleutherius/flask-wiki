Flask-wiki
----

[![Build Status](https://travis-ci.org/eleutherius/flask-wiki.svg?branch=master)](https://travis-ci.org/eleutherius/flask-wiki)
[![BSD license](https://img.shields.io/pypi/l/flask.svg)](
https://github.com/eleutherius/flask-wiki/blob/master/LICENSE)
[![built with Python3](https://img.shields.io/badge/built%20with-Python3-red.svg)](
https://www.python.org/)


My desire is to make a beautiful and comfortable wiki.  

## About
This project based on [alexanderjulo/wiki](https://github.com/alexanderjulo/wiki) and [guzmanc1/RikiWiki](https://github.com/guzmanc1/RikiWiki) projects.

Appearance of the application
![Home page](https://raw.githubusercontent.com/eleutherius/flask-wiki/master/doc/img1.png)
![Articles](https://raw.githubusercontent.com/eleutherius/flask-wiki/master/doc/img1.png)

## Features
* Markdown Syntax Editing
* Tags
* Regex Search
* Random URLs
* Web Editor
* Pages can also be edited manually, possible uses are:
    * use the cli
    * use your favorite editor
    * sync with dropbox
    * and many more
* Bootstrap 4 like frontend.
* Python3 compatibility only.

## Roadmap

- [ ]  Re-introduce support for customizing the theme
- [ ]  Speed Improvements
	- [ ] Code Optimizations
	- [ ] Add databases support
- [ ] Settings via the web interface
- [ ] Improved  embed markdown editor

## Demo
You can used Demo of RikiWiki project.
You can access the wiki [http://wiki440.ms2ms.com](http://wiki440.ms2ms.com). login:name, pass:1234.

## Configuration
1. Update CONTENT_DIR and USER_DIR in config.py
2. When you want to use login, make PRIVATE = True in config.py. Remember you can use id "name" and password "1234".

## Process
1. create virtualenv name `env` in the Riki-deploy directory.
2. source env/bin/activate
3. pip install -r requirements.txt
4. Modify the location of CONTENT_DIR in config.py. `CONTENT_DIR = '/Users/smcho/PycharmProjects/Riki/content'`
5. Restart the uwsgi - `sudo restart uwsgi`
6. sudo chown -R www-data:www-data content

## Usage
I use this wiki as working notes for myself.

## Development & Contributors
 Fork me!
