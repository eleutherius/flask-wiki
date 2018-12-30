Docker test buid enviroument
----

```
WARNING: Do not use the development server in a production environment.
```
You can quickly test Flask-wiki application in your docker. Caution do not use it in a production environment.

Use to run in the background
```
docker-compose up -d --force-recreate
```
For rebuild docker container
```
docker-compose --build
```