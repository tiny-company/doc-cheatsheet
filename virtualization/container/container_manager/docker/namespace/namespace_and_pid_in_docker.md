# namespace and pid in docker

In Docker, namespaces are a feature of the Linux kernel that provide isolation between processes. Docker leverages namespaces to create isolated environments for containers. Each container runs in its own set of namespaces, including the PID (Process ID) namespace, which is specifically related to the process isolation aspect. Here's how namespaces work in Docker and how they are linked to the PID:
Namespaces Overview:

    PID Namespace:
        The PID namespace isolates the process IDs seen by a set of processes. Each container gets its own PID namespace, which means that the processes running inside the container have their own set of PIDs.
        The first process inside a container is typically assigned PID 1 and is considered the init process. This process is responsible for managing other processes within the container.

    Other Important Namespaces:
        Docker uses multiple namespaces to provide isolation, including the Network Namespace (for network isolation), Mount Namespace (for filesystem isolation), IPC Namespace (for inter-process communication isolation), UTS Namespace (for hostname and domain name isolation), and User Namespace (for user and group ID isolation).

How Namespaces Link to PID:

    Isolation:
        Each container in Docker runs in its own set of namespaces, ensuring that the processes inside a container are isolated from the processes on the host system and other containers.

    Unique PIDs:
        The PID namespace ensures that processes inside a container have their own set of unique PIDs, starting from 1. This allows the processes to be managed independently within the container.

    PID Mapping:
        The host system manages the actual PID namespace. Docker uses PID mapping to map the PIDs inside a container to PIDs on the host system. This mapping allows Docker to reconcile the differences between the PIDs inside the container and the PIDs on the host.

    Process Lifecycle:
        When a container is started, its init process is assigned PID 1 within its own PID namespace. This init process is responsible for managing the lifecycle of other processes within the container.
        When the container is stopped or killed, all the processes within its PID namespace are terminated.


below a simplified scheme that show namespace isolation on the host system and the pid inside of it : 

```
Host System
+----------------------------------+
| Namespace 1 (Host PID Namespace) |
|   PID 1                          |
|   PID 2                          |
|   ...                            |
+----------------------------------+
| Namespace 2 (Container PID Namespace) |
|   PID 1 (Container init process)  |
|   PID 2 (Container application process) |
|   PID 3 (Other processes)         |
|   ...                            |
+----------------------------------+
```