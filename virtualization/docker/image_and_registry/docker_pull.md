# docker pull 

command is used to get docker image from registry 

## Get image from github image registry

- Get image from a classic github registry :
```
docker pull ghcr.io/NAMESPACE/IMAGE_NAME:latest
```

- If authentication is needed, use these command :
```
docker login --username foo 
docker pull ghcr.io/NAMESPACE/IMAGE_NAME:latest
```

## Sources : 

- [docker pull command man](https://docs.docker.com/engine/reference/commandline/pull/)