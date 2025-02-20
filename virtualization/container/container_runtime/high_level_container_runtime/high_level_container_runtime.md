# high level container runtime 

## Description 

High-level runtimes are higher up the stack than low-level runtimes. While low-level runtimes are responsible for the mechanics of actually running a container, high-level runtimes are responsible for transport and management of container images, unpacking the image, and passing off to the low-level runtime to run the container. Typically, high-level runtimes provide a daemon application and an API that remote applications can use to logically run containers and monitor them but they sit on top of and delegate to low-level runtimes or other high-level runtimes for the actual work.

High-level runtimes can also provide features that sound low-level, but are used across individual containers on a machine. For example, one feature might be the management of network namespaces, and allowing containers to join another container’s network namespace.

## Sources : 

- [Container Runtimes Part 3: High-Level Runtimes](https://www.ianlewis.org/en/container-runtimes-part-3-high-level-runtimes)