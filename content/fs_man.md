title: Работа с файловыми системами в  Linux 
tags: 

### Узнаем файловую систему на дисках 
Пример, чтобы определить, какая файловая система на разделе /dev/sda1, наберите в командной строке команду file с ключем -s:
```
file -s /dev/sda1
```
Один из возможных ответов на команду:
```
/dev/sda1: Linux rev 1.0 ext3 filesystem data, UUID=9c9a0d52-4ee2-4124-b7c1-46d4a2fc1878 (large files)
```
Т.е. мы видим, что раздел /dev/sda1 имеет тип ext3

Как это всегда бывает в системах типа Linux/UNIX, требуемый результат можно получить множеством способов. Определить файловую систему для смонтированных разделов можно с помощью команды df с ключем -T:
```
df -T
Filesystem    Type   1K-blocks      Used Available Use% Mounted on
/dev/sda1     ext3    50395844  21934060  25901784  46% /
tmpfs        tmpfs      867384       440    866944   1% /dev/shm
```
Если же раздел не смонтирован, то поможет команда file с ключем -s, как указано выше.