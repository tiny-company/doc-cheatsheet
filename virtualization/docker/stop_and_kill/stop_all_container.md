# Stop all container

To stop all running container with a single command :
```
docker stop $(docker container ls -q)
```

To stop all container with a single command :
```
docker stop $(docker container ls -qa)
```

This command does the following:

- `docker container ls -q` returns the list of ids of all running containers;
- `docker stop` attempts to trigger a graceful termination of the containers (by sending the SIGTERM signal to the main process inside the container).

## Stop and rm all container 

```
docker ps -aq | xargs docker stop | xargs docker rm
```

reminder : Xargs is a Linux utility that accepts entries from its input and executes the command you specify for each entry.

## Source : 

- [container stop guide](https://www.designcise.com/web/tutorial/how-to-stop-all-docker-containers)
- [container stop and rm guide](https://www.cloudbees.com/blog/docker-how-to-stop-and-remove-all-containers-at-once)