title: Создаем юзера без возможности логинится по ssh
tags: 

Вот как-то так: 

```
useradd alex -d /dev/null -s /bin/false
```