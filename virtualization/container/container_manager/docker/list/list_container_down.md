# List container down

- To list only container that are down :
```
docker ps --filter "status=exited"
```

- To list all container in a non up status :
```
docker container ls -f 'status=exited' -f 'status=dead' -f 'status=created'
```

- Other status are :
    - created
    - restarting
    - running
    - removing
    - paused
    - exited
    - dead
