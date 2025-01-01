# user in docker

Users  usage id docker can be difficult to understand as multiple users can be use to run a container depending on the user usage on the different component of docker :
- docker daemon : user that run the docker daemon service that run manage docker in background.
- docker user on the host : user that is associated with the container main process ID.
- docker user on the container : user that is used to run all command/service under the container.

## user for docker daemon

By default docker daemon (docker service that managed docker as a background service) run as *root* user. To install docker daemon as non root user see [This docker official documentation](https://docs.docker.com/engine/security/rootless/).

Running the Docker daemon as the root user can pose security risks due to the potential for privilege escalation and unauthorized access :
- If the Docker daemon runs as the root user, any compromise of the Docker daemon could potentially lead to full root access on the host system
- Containers share the host kernel with the Docker daemon. Running the Docker daemon as root means that containers have access to the host's resources, and a compromised container could potentially affect the entire host
- Containers can mount parts of the host file system. If the Docker daemon runs as root, a compromised container might gain access to sensitive files on the host system.
- Containers can communicate with the host and other containers. Running the Docker daemon as root means that containers might have broader network access than they would if the daemon were running with reduced privileges.
- Containers share the same kernel as the host. If there are kernel vulnerabilities, a compromised container may exploit them to affect the host system. Running the Docker daemon as a non-root user provides an additional layer of isolation.
- Running Docker as root makes it challenging to use user namespace remapping, which is a security feature that allows mapping container user and group IDs to non-root user and group IDs on the host.

## user for docker on the host

Docker supports the concept of user namespace remapping, which allows you to map container user and group IDs to non-root user and group IDs on the host. This can be useful for enhancing security and ensuring proper permissions.

### Without User Namespace Remapping:

- On the host, you have a directory (e.g., /host-data) with specific ownership and permissions
- In the container, you mount a volume to a directory (e.g., /container-data). By default, the user and group IDs inside the container are the same as on the host. If the user inside the container (specified by UID and GID) does not exist on the host, Docker will still try to apply the specified UID and GID when interacting with the host filesystem.

### With User Namespace Remapping:

- On the host, you have a directory (e.g., /host-data) with specific ownership and permissions
- In the container, you mount a volume to a directory (e.g., /container-data). Due to user namespace remapping, the user and group IDs inside the container are remapped to non-root IDs on the host.

## user under docker container

User under container could be define is multiple ways :
- [dockerfile](#dockerfile)
- [docker-compose](#docker-compose)

### dockerfile :

@TODO

### docker-compose :

In this example, during the build process, the USER_ID and GROUP_ID arguments are passed to the Dockerfile, and the user attribute is set to use these identifiers when running the container. This args `user` could also be user in a container without `build`, replacing default user declared in the dockerfile.

```
version: '3'
services:
  webapp:
    build:
      context: .
      dockerfile: Dockerfile
      args:
        - USER_ID=1000
        - GROUP_ID=1000
    user: "${USER_ID}:${GROUP_ID}"
```

## Sources :

- [userns-remap docker documentation](https://docs.docker.com/engine/security/userns-remap/)