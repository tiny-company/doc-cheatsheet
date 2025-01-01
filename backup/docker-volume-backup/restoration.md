# restoration backup

## Restore by copying files into volumes

To restore a volume from a backup proceed with steps below :

- Stop the container(s) that are using the volume

- Untar the backup you want to restore :
```
tar -C /tmp -xvf  backup.tar.gz
```

- Using a temporary once-off container, mount the volume (the example assumes it’s named data) and copy over the backup :

```
docker run -d --name temp_restore_container -v data:/backup_restore alpine
docker cp /tmp/backup/data-backup temp_restore_container:/backup_restore
docker stop temp_restore_container
docker rm temp_restore_container
```

- Restart the container(s) that are using the volume

### Restore by recreating a new volume

If you want to rollback an entire volume to an earlier backup snapshot (recommended for database volumes):

- Trigger a manual backup if necessary (see Manually triggering a backup).

- Stop the container(s) that are using the volume.

- If volume was initially created using docker-compose, find out exact volume name using:
```
docker volume ls
```

- Remove existing volume (the example assumes it’s named data):
```
docker volume rm data
```

- Create new volume with the same name and restore a snapshot:
```
docker run --rm -it -v data:/backup/my-app-backup -v /path/to/local_backups:/archive:ro alpine tar -xvzf /archive/full_backup_filename.tar.gz
```

- Restart the container(s) that are using the volume.

## Sources :

- [official restore offen documentation](https://offen.github.io/docker-volume-backup/how-tos/restore-volumes-from-backup.html)