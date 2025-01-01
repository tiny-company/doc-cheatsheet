# Remove orphean volume

- list all orphean volumes :
```
docker volume ls -qf dangling=true
```

- Delete all listed orphean volumes :
```
docker volume rm $(docker volume ls -qf dangling=true)
```

## Source :

- [howchoo.com tutorial](https://howchoo.com/docker/how-to-remove-orphaned-volumes-in-docker/)