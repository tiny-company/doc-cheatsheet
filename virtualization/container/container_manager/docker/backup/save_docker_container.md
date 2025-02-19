# save container docker

## Description 

Sometime you want to test, or make an update on a container configuration but you are not sure if it will break or not the container. So making a quick backup/save of the container is a good idea, find how to do it below :

>Note : This will not save the volumes, only the container !

<br>

**Don't Forget to [delete the backup when not usefull anymore](#after-restore-or-after-operation)**

<br>

## Step 1 : docker commit 

- [Link to docker commit documentation](https://docs.docker.com/engine/reference/commandline/commit/)

```
docker commit -m "commit message" <container ID> registry/image_name:version 
```

Here is an example :


```
docker commit -m "backup 13/02/2025 of postgresql c3f279d17e0a  webdronesas/postgresql:backup_13_02_2025 "
```

- Then go check your image :

```
docker images
```

## Step 2 : docker save 

- [link to docker save documentation](https://docs.docker.com/engine/reference/commandline/save/)

- Then create a tar of the image using docker save :

```
docker save --output /tmp/postgresql_backup_13_02_2025.tar webdronesas/postgresql:backup_13_02_2025
```

Then check your file :
```
ls -sh /tmp
```


## Restore 

> Note "docker load" and "docker image load" is the same command, just an alias.

- [Link to docker load documentation](https://docs.docker.com/engine/reference/commandline/image_load/)

If you need to restore the container from your backup container , do :
```
docker load --input /tmp/postgresql_backup_13_02_2025.tar
```


It will create a new image named "webdronesas/postgresql:backup_13_02_2025", now delete the old image, tag the new image
```
docker rmi webdronesas/postgresql:latest
docker tag webdronesas/postgresql:backup_13_02_2025 webdronesas/postgresql:latest
```

and you could start the container using `docker start` or `docker-compose up`.

For avoid any error later delete the docker image as it is not the original (it is the backup we just created, but renamed) :
```
docker rmi webdronesas/postgresql:latest
```

## After restore or after operation 

Don't forget to delete the image and the tar when you don't need it anymore :
```
rm /tmp/postgresql_backup_13_02_2025.tar
docker rmi webdronesas/postgresql:backup_13_02_2025
```

## Sources :

- [Official documentation to save and restore container](https://docs.docker.com/desktop/backup-and-restore/)
- [Another tutorial for backing up container - from tutorialspoint](https://www.tutorialspoint.com/how-to-backup-and-restore-a-docker-container)