# Installation guide

### nginx config example

```
upstream flask_serv {
    server unix:/run/uwsgi/app/wiki/wiki.sock;
}
server {
    listen 80;
    server_name flask-wiki.tk;
    rewrite ^(.*)$ https://flask-wiki.tk/$1 permanent;
    access_log /var/log/nginx/wiki_access.log;
    error_log /var/log/nginx/wiki_error.log;

}
 server{
        listen 443 ssl http2;
        server_name flask-wiki.tk www.flask-wiki.tk;
    access_log /var/log/nginx/flask-wiki.tk.log;
    error_log /var/log/nginx/flask-wiki.tk.log;

    ssl on;
    ssl_certificate    /etc/letsencrypt/live/flask-wiki.tk/fullchain.pem; 
    ssl_certificate_key  /etc/letsencrypt/live/flask-wiki.tk/privkey.pem;
    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers         HIGH:!aNULL:!MD5;

    location / {
        uwsgi_pass flask_serv;
        include uwsgi_params;
        auth_basic "Please, enter login and password";
        auth_basic_user_file    "/etc/nginx/.htpasswd";
    }
 }
```
### uwsgi config example

```
<uwsgi>
    <socket> /run/uwsgi/app/wiki/wiki.sock</socket>
    <pythonpath>/var/www/Flask-Wiki/</pythonpath>
    <module>application:app</module>
    <plugins>python3</plugins>
    <virtualenv>/var/www/Flask-Wiki/venv/</virtualenv>
    <app mountpoint="/var/www/Flask-Wiki/">
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
</uwsgi>
```

uwsgi_enable