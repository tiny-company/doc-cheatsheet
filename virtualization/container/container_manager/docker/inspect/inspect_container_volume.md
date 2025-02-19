# inspect docker volume

- to inspect volume on a container use the format option and jq cmd :
```
docker inspect --format="{{json .Mounts}}\n" BP_DEMO_neo4j | jq
```

it will output all mount under the wanted image in json format :
```
[
  {
    "Type": "volume",
    "Name": "792cf268f40d5c8402161893fa5d84ca3dc2ec544ccc297099b2a0e87ad712d0",
    "Source": "/var/lib/docker/volumes/792cf268f40d5c8402161893fa5d84ca3dc2ec544ccc297099b2a0e87ad712d0/_data",
    "Destination": "/logs",
    "Driver": "local",
    "Mode": "",
    "RW": true,
    "Propagation": ""
  },
  {
    "Type": "bind",
    "Source": "/data/webdrone/neo4j_cluster/core1",
    "Destination": "/data",
    "Mode": "rw",
    "RW": true,
    "Propagation": "rprivate"
  },
  {
    "Type": "bind",
    "Source": "/backup/webdrone/neo4j/main",
    "Destination": "/backup",
    "Mode": "rw",
    "RW": true,
    "Propagation": "rprivate"
  },
  {
    "Type": "bind",
    "Source": "/var/log/webdrone/BP_DEMO_neo4j_BP_DEMO",
    "Destination": "/var/lib/neo4j/logs",
    "Mode": "rw",
    "RW": true,
    "Propagation": "rprivate"
  }
]
```

> Note looking for Volumes (instead of Mounts) will only list empty volume list (see below) :

```
docker inspect --format="{{json .Config.Volumes}}\n" BP_DEMO_neo4j | jq
{
  "/backup": {},
  "/data": {},
  "/logs": {},
  "/var/lib/neo4j/logs": {}
}
```

## Sources :

- [docker inspect official documentation](https://docs.docker.com/engine/reference/commandline/inspect/#usage)
- [docker formating official documentation](https://docs.docker.com/config/formatting/)