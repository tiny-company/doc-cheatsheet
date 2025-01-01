# list user under container

- To list all user under each container at format 'user container' :
```
docker inspect $(docker ps -q) --format '{{.Config.User}} {{.Name}}'
```

## Source :

- [stackoverflow topic about showing user under container](https://stackoverflow.com/questions/50549356/how-can-i-see-which-user-launched-a-docker-container)