1# Readme
 My desire is to make a beautiful and comfortable wiki.  
## About
This project based on alexanderjulo/wiki and guzmanc1/RikiWiki projects.
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
* Bootstrap4 like frontend.
* Python3 compatibility only.
### Planned
* Re-introduce support for customizing the theme
* Speed Improvements
	* Code Optimizations
	* Caching
* Settings via the webinterface
* Improved  embed marcdown editor
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
