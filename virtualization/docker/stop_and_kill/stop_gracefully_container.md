# Stop gracefully a container 

## Description 

docker will send a nicely order SIGTERM to stop the container process and will fater default 10 second order a SIGKILL, wich could cause data corruption (example for database).

To change this default time add the `--time=value` in order to let more time to your contianer to stop :
```
docker stop <container_name> --time=120
```

## Source 

- [docker stop documentation](https://docs.docker.com/engine/reference/commandline/stop/)
