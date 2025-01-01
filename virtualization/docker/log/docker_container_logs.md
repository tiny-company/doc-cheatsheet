# Docker container logs

## Description 

There is multiples log source for the docker containers :
- logs of the docker container itself (which is the log of the main process : PID = 1) : This could be a process (mariadb, nginx, etc ...) or it could be an endpoint script (start_service.sh).
- logs of the docker container services : This service generally create a log file that can be mounted on the host.

## Usage 

### See container main process log :

- See container main process (PID = 1) logs in cmd line:
```
docker logs <container_name_or_container_ID>
```

- See container main process (PID = 1) logs from file :
```
/var/lib/docker/containers/<full_container_ID>/<container_ID>-json.log
```

To find the full_container ID, look at the first element, example :
`docker ps` give :

    d5448dd1f00e

`ls /var/lib/docker/containers/` give :

    1d7f113b1a20248defc9947d4d5e5675336d18bd08c761252967c11e9030ae24/ 639a1c6810b7aae134e04b7d55e8322c43b99cbe466a1d541db9488253b70a52/
    2681af4e257ab5fb9dad84e24edb3699e6db53c956438aecd872217f312f7e72/ ==>d5448dd1f00ee5b74e49ffe60fc9462105b521e291852565425eecb371d78add/

just use cat, less, or any cmd to open classic log file.

### See container service log :

- If the correct volume mapping have been made, you should have the container service logs in your classic "/var/log" directory.

