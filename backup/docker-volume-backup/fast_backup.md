# fast and simple backup

You can manually trigger a backup run outside of the defined cron schedule by executing the backup command inside the container:

```
docker exec <container_ref> backup
```

## source :

- [trigger a backup manually](https://offen.github.io/docker-volume-backup/how-tos/manual-trigger.html)