#!/bin/bash
# Need to install some packages: nginx, uwsgi, uwsgi-plugin-python3
function system_checks () {
if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root"
   	exit 1
fi

if [ "$(uname -s)" != "Linux" ]; then
	echo "Error: Can run on Linux only"
	exit 1
fi
}
#
# default  variables
#
DNS_NAME="_"
FLASK_WIKI="flask-wiki"
BASE_DIR="/var/www/$FLASK_WIKI"
TITLE="\E[0;0f
###################################################
#                                                 #
#              Flask-wiki installer               #
# We will install nginx and uwsgi on your machine #
#                                                 #
###################################################
\n
\n
\n
"
tabs 4
clear
echo -en "$TITLE"

function update() {
 apt update
 apt install -y nginx-light  uwsgi-core uwsgi uwsgi-plugin-python3 python3-virtualenv unzip python3 python3-pip python3-venv
}
# unswer function
function ask() {
     local prompt default reply

     while true; do

         if [ "${2:-}" = "Y" ]; then
             prompt="Y/n"
             default=Y
         elif [ "${2:-}" = "N" ]; then
             prompt="y/N"
             default=N
         else
             prompt="y/n"
             default=N
         fi

         # Ask the question (not using "read -p" as it uses stderr not stdout)
         echo -n "$1 [$prompt] "

         # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
         read reply </dev/tty

         # Default?
         if [ -z "$reply" ]; then
             reply=$default
         fi

         # Check if the reply is valid
         case "$reply" in
             Y*|y*) return 0 ;;
             N*|n*) return 1 ;;
         esac

     done
 }

function dns() {
echo "Put your DNS name: "
read DNS_NAME
 if ask "Are you are sure that your domain is called $DNS_NAME ?"; then
   echo "Ok!"
  X=$DNS_NAME
 else
     echo "Plese check again! "
     exit 1
 fi
}
function nginx_config () {
echo "
upstream flask_serv {
    server unix:/run/uwsgi/app/wiki/${FLASK_WIKI}.sock;
}

server {
    access_log /var/log/nginx/${FLASK_WIKI}_access.log;
    error_log /var/log/nginx/${FLASK_WIKI}_error.log;
    listen 80;
    server_name ${DNS_NAME};

    location / {
        uwsgi_pass flask_serv;
        include uwsgi_params;

    }

}" >>  "/etc/nginx/sites-available/${FLASK_WIKI}.conf"
ln -s  "/etc/nginx/sites-available/${FLASK_WIKI}.conf" /etc/nginx/sites-enabled/
}

function uwsgi_config () {
echo"
<uwsgi>
    <socket> /run/uwsgi/app/wiki/${FLASK_WIKI}.sock</socket>
    <pythonpath>${BASE_DIR}</pythonpath>
    <module>application:app</module>
    <plugins>python3</plugins>
    <virtualenv>/var/www/Flask-Wiki/venv/</virtualenv>
    <app mountpoint="${BASE_DIR}">

        <script>wsgi_configuration_module</script>

    </app>
    <master/>
    <processes>4</processes>
    <harakiri>60</harakiri>
    <reload-mercy>8</reload-mercy>
    <cpu-affinity>1</cpu-affinity>
    <stats>/tmp/stats.socket</stats>
    <max-requests>2000</max-requests>
    <limit-as>512</limit-as>
    <reload-on-as>256</reload-on-as>
    <reload-on-rss>192</reload-on-rss>
    <no-orphans/>
    <vacuum/>

</uwsgi>" >> "/etc/uwsgi/apps-available/${FLASK_WIKI}.xml"
ln -s   "/etc/uwsgi/apps-available/${FLASK_WIKI}.xml" /etc/uwsgi/apps-enabled/
}

function download () {
wget "https://github.com/eleutherius/Flask-Wiki/archive/master.zip"
unzip master.zip
mv Flask-Wiki-master $BASE_DIR
rm -rf Flask-Wiki-master master.zip
chown -R www-data:www-data  $BASE_DIR
}
function restart () {
service nginx restart &&  service uwsgi restart
}

function venv_install () {
  cd "$BASE_DIR"
  pip3 install virtualenv
  python3 -m venv venv
  if [[ "$?" -eq 0 ]]; then
  source venv/bin/activate
  pip install -r requirements.txt
else printf "problem with venv!"
fi
}

function install() {
    update
    download
    venv_install
    uwsgi_config
    nginx_config
    restart
    echo "Installation complite!"
}

function delete_py() {
DEL="python"
for prog in `dpkg -l | grep "$DEL" | awk '{print $2}'`; do apt-get remove --purge $prog -y; done
apt autoremove -y
}
function delete_py3() {
DEL="python3"
for prog in `dpkg -l | grep "$DEL" | awk '{print $2}'`; do apt-get remove --purge $prog -y; done
apt autoremove -y
}
function delete_ng() {
DEL="nginx"
for prog in `dpkg -l | grep "$DEL" | awk '{print $2}'`; do apt-get remove --purge $prog -y; done
apt autoremove -y
}
function delete_wg() {
DEL="uwsgi"
for prog in `dpkg -l | grep "$DEL" | awk '{print $2}'`; do apt-get remove --purge $prog -y; done
apt autoremove -y
}
function delete() {
  while true; do
    echo "== Make your selection:"
    echo "a) Uninstall python2 & python3"
    echo "b) Uninstall python3"
    echo "c) Uninstall nginx"
    echo "d) Uninstall uwsgi"
    echo "q) quit"
    while true; do
      read -r -n1 -p "> " ch
      echo
      case $ch in
        a) delete_py; break;;
        b) delete_py3; break;;
        c) delete_ng; break;;
        d) delete_wg; break;;
        q) break 2 ;;
        *) echo "Unrecognized command.  Please try again.";;
      esac
    done
  done
}
# Import main functions
function main() {
  while true; do
    echo "== Make your selection:"
    echo "a) Install Flask-Wiki"
    echo "s) Uninstall Flask-Wiki"
    echo "q) quit"
    while true; do
      read -r -n1 -p "> " ch
      echo
      case $ch in
        a) install; break;;
        s) delete; break;;
        q) exit 0;;
        *) echo "Unrecognized command.  Please try again.";;
      esac
    done
  done
}

# Run system checks
system_checks
# main
main


#END OF SCRIPT
