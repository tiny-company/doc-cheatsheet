# docker push

## Description

docker push action will send a local image to a distant repository (by default Docker hub).

## Prerequisite 

- Be sure to have access to the distant repository (make sure to launch `docker login --username username` if not already done)

## Usage 

- Before pushing the image, you will need to tag it :
```
docker tag docker/welcome-to-docker:<tag> <distant_repository>/welcome-to-docker:<tag>
```

`<distant_repository>` can be an organisation or user-name (depending on where you want it to be store on dockerhub).


- Then you can push the image :
```
docker push welcome-to-docker:<tag>
```