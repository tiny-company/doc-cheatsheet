# filter the show container cmd

- show only container id with "chrome" in their name :
```
docker container ls -q -f name=chrome
```

- To use the output in another function use $(), example to stop all the listed container :
```
docker stop $(docker container ls -q -f name=chrome)
```

-To show ip address and container name of running container :
```
docker inspect -f '{{.Name}} {{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -q)
```

- To have a column output :
```
(echo "NAME IP"; docker inspect $(docker ps -q) --format "{{.Name}} {{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}") | column -t -s ' '
```

## Source :

- [docker inspect output as table](https://stackoverflow.com/questions/65648918/docker-inspect-format-its-output-as-a-table)