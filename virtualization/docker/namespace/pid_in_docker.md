# PID in docker

In Docker, the Process ID (PID) is a unique identifier assigned to each running process within a container. Docker containers are lightweight and isolated environments, and each container has its own PID namespace. The PID namespace provides isolation between the processes running inside a container and those running on the host system or other containers.

PID Namespace:

    Docker uses namespaces to provide process isolation. The PID namespace is one of the namespaces Docker employs.
    Each container has its own PID namespace, which means that the processes running inside the container have their own set of process IDs that are isolated from the PIDs on the host system or other containers.

Process Isolation:

    When you run a container, the processes inside that container are assigned PIDs starting from 1. These PIDs are specific to the container and do not conflict with PIDs on the host or other containers.
    For example, the process with PID 1 inside a container might be the init process or the main application process running in the container.

Viewing Processes in a Container:

    You can view the processes running inside a container using commands like docker exec or by attaching to a running container.
    Example:

    bash

    docker exec -it <container_id_or_name> bash

    This command opens a shell inside the specified container, allowing you to view and interact with the processes.

PID Mapping:

    The host system still manages the actual PID namespace, and Docker uses PID mapping to map the container's PIDs to the host's PID namespace.
    For example, if a container has a process with PID 1, it might be mapped to a different PID on the host system.

Container Lifecycle:

    When a container is started, its main process (typically defined in the Dockerfile or Docker Compose file) is assigned PID 1.
    When the container stops or is killed, all the processes running inside the container are terminated.



Scheme that illustrate host and container isolation :
```
Host System                 Container
+-------------+             +-------------+
| PID 1       |             | PID 1       |  (Container init process)
| PID 2       |             | PID 2       |  (Container application process)
| PID 3       |             | PID 3       |  (Other processes)
| ...         |             | ...         |
+-------------+             +-------------+

```


## PID mapping

In Docker, PID mapping is a mechanism used to map the Process IDs (PIDs) of processes running inside a container to the PIDs on the host system. This allows Docker to maintain the appearance of process isolation within containers while reconciling the differences between the container's PID namespace and the host's PID namespace.

### How PID Mapping Works:

1. **Container PID Namespace:**
   - Each container runs in its own PID namespace, isolating the processes within the container from the host system.

2. **Init Process and PIDs:**
   - The init process inside a container is typically assigned PID 1 within the container's PID namespace.
   - Processes within the container have their own unique PIDs, starting from 1.

3. **Host PID Namespace:**
   - The host system has its own PID namespace with its set of PIDs.
   - Docker uses PID mapping to map the PIDs inside the container to PIDs on the host system.

4. **Mapping Logic:**
   - The mapping is typically managed by the container runtime, such as Docker. The mapping logic ensures that PIDs inside the container do not conflict with PIDs on the host system.

5. **Terminology:**
   - The PID 1 inside the container might be mapped to a different PID on the host system, and the same applies to other processes within the container.

### Example:

Consider a simple Docker container running a web server. The Dockerfile might look like this:

```Dockerfile
# Use a lightweight base image
FROM alpine:latest

# Install a web server (e.g., Nginx) and a simple script
RUN apk --no-cache add nginx
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Start the web server on port 80
CMD ["/start.sh"]
```

In the `start.sh` script, you might have:

```bash
#!/bin/sh
nginx -g "daemon off;"
```

Now, let's build and run the Docker container:

```bash
# Build the Docker image
docker build -t my-web-server .

# Run the Docker container
docker run -d -p 8080:80 my-web-server
```

In this example, the web server process (likely Nginx) inside the container will be assigned PID 1 within the container's PID namespace. However, when you check the host system, you will likely see a different PID mapping.

To inspect the PID mappings, you can use tools like `ps` or `docker inspect`. For example:

```bash
# Get the PID of the Nginx process inside the container
CONTAINER_PID=$(docker inspect --format '{{ .State.Pid }}' <container_id_or_name>)

# Check the PID mapping on the host system
ps aux | grep $CONTAINER_PID
```

This example demonstrates that PID 1 inside the container is mapped to a different PID on the host system, and the same applies to other processes within the container.