# low level container runtime 

## Description

When folks think of container runtimes, a list of examples might come to mind; runc, lxc, lmctfy, Docker (containerd), rkt, cri-o. Each of these is built for different situations and implements different features. Some, like containerd and cri-o, actually use runc to run the container but implement image management and APIs on top. You can think of these features – which include image transport, image management, image unpacking, and APIs – as high-level features as compared to runc’s low-level implementation.

So for practical purposes, actual container runtimes that focus on just running containers are usually referred to as “low-level container runtimes”. Runtimes that support more high-level features, like image management and gRPC/Web APIs, are usually referred to as “high-level container tools”, “high-level container runtimes” or usually just “container runtimes”. I’ll refer to them as “high-level container runtimes”. It’s important to note that low-level runtimes and high-level runtimes are fundamentally different things that solve different problems.

## Sources :

- [Container Runtimes Part 1: An Introduction to Container Runtimes](https://www.ianlewis.org/en/container-runtimes-part-1-introduction-container-r)