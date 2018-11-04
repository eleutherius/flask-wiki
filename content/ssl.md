title: SSL + NGINX + PHP-fpm
tags: #php, #nginx, #ssl

SSL серитификаты генерим через certobot  
Для ограничения в хода в одлельные подпапки  устнавливаем 
```shell
apache2-utils 
```
/etc/nginx/conf.d/

```shell
 server{
        listen 443 ssl http2;
        server_name teneta.ml www.teneta.ml;
	access_log /var/log/nginx/teneta.ml_access.log;
	error_log /var/log/nginx/teneta.ml_error.log;

	ssl on;
	ssl_dhparam	/etc/nginx/sslcerts/dhparam.pem;
	ssl_certificate    /etc/letsencrypt/live/teneta.ml/fullchain.pem; 
	ssl_certificate_key  /etc/letsencrypt/live/teneta.ml/privkey.pem;
	ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers         HIGH:!aNULL:!MD5;

	root   /var/www/alex/web/teneta.ml;
	index index.php;
	      location ~* \.(jpg|jpeg|gif|png|bmp|ico|pdf|flv|swf|exe|html|htm|txt|css|js)$ {
	root /var/www/alex/web/teneta.ml;
	}
  

	location / {
            try_files $uri $uri/ /index.php?$args;
            }

	location /wp-admin {
	auth_basic "Please, enter login and password";
	auth_basic_user_file	"/var/www/alex/.htpasswd";
	}
	location /phpmyadmin {
        auth_basic "Please, enter login and password";
        auth_basic_user_file    "/var/www/alex/.htpasswd";
        }

        location ~ \.php$ {
		fastcgi_pass unix:/var/run/php/php7.2-teneta-fpm.sock;
		include fastcgi_params;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }

        location ~ /\.ht {
              deny all;
        }
}

	server {
	listen 80;
	server_name www.teneta.ml;
	rewrite ^(.*)$ https://teneta.ml/$1 permanent;
	}

```

/etc/php/7.2/fpm/pool.d/teneta.ml

```
[teneta.ml]

user = alex
group = alex
listen = /var/run/php/php7.2-teneta-fpm.sock

listen.owner = alex
listen.group = www-data
listen.mode = 0660
;listen.acl_users =
;listen.acl_groups =

chdir = /
pm = dynamic

pm.max_children = 10

pm.start_servers = 3

pm.min_spare_servers = 3

pm.max_spare_servers = 10

;pm.process_idle_timeout = 10s;

;pm.max_requests = 500

;php_admin_value[sendmail_path] = /usr/sbin/sendmail -t -i -f www@my.domain.com
;php_flag[display_errors] = off
php_admin_value[error_log] = /var/log/fpm-php.teneta.log
php_admin_flag[log_errors] = on
php_admin_value[memory_limit] = 512M

```