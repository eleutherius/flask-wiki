title: Удаляем весь мусор от установок  Debian
tags: #dpkg

удаляем все! 

```shell
dpkg -l | grep MySQL 
apt-get remove --purge $MySQL_packets 
apt-get autoremove
```


Смотрим все проессы dpkg 
```
ps -ef | grep dpkg
```

Смотрим вторую колонку ```dpkg -l```
```
dpkg -l | grep php7.1 | awk '{print $2}'
```

Пример однострочного скрипта для удаления всякого мусора: 

```
for prog in `dpkg -l | grep php7.1 | awk '{print $2}'`; do apt-get remove --purge $prog -y; done

```

