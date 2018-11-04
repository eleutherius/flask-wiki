#!/bin/bash
# Need to install some packages: nginx, uwsgi, uwsgi-plugin-python3
if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root"
   	exit 1
fi
 echo -en "\E[2J"

 echo -en "\E[2J"
 echo -en "\E[0;0f
 ###################################################
 #                                                 #
 #              Flask-wiki installer               #
 # We will install nginx and uwsgi on your machine #
 #                                                 #
 ###################################################
 "


 echo " "
 echo " "
 echo " "
 echo "Installing... "
 sleep 2
 apt update
 apt install nginx-light  uwsgi-core uwsgi uwsgi-plugin-python3 python3-virtualenv unzip

# unswer function



 ask() {
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
             default=
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

echo "Put your DNS name: "
read B

 if ask "Are you are sure that your domain is called $B ?"; then
   echo "Ok!"
  X=$B
 else
     echo "Plese check again! "
     exit 1
 fi

echo "
upstream flask_serv {
    server unix:/run/uwsgi/app/wiki/$X.sock;
}

server {
    access_log /var/log/nginx/wiki_access.log;
    error_log /var/log/nginx/wiki_error.log;
    listen 80;
    server_name $X;

    location / {
        uwsgi_pass flask_serv;
        include uwsgi_params;

    }

}" >>  /etc/nginx/sites-available/$X.conf
ln -s  /etc/nginx/sites-available/$X.conf /etc/nginx/sites-enabled/

echo"
<uwsgi>
    <socket> /run/uwsgi/app/wiki/$X.sock</socket>
    <pythonpath>$BASE_DIR</pythonpath>
    <module>application:app</module>
    <plugins>python3</plugins>
    <virtualenv>/var/www/Flask-Wiki/venv/</virtualenv>
    <app mountpoint="$BASE_DIR">

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

</uwsgi>" >> /etc/uwsgi/apps-available/$X.xml
ln -s   /etc/uwsgi/apps-available/$X.xml /etc/uwsgi/apps-enabled/

wget https://github.com/eleutherius/Flask-Wiki/archive/master.zip
unzip master.zip
mv Flask-Wiki-master $BASE_DIR
rm -rf Flask-Wiki-master master.zip
chown -R www-data:www-data  $BASE_DIR

service nginx restart &&  service uwsgi restart
