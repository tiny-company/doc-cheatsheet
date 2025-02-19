# kata overview

## Description

Kata Containers is an open source project and community working to build a standard implementation of lightweight Virtual Machines (VMs) that feel and perform like containers, but provide the workload isolation and security advantages of VMs.

![kata isolation feature](https://katacontainers.io/static/6e497f9d3752ca1e354d0d2949abc020/8fef6/katacontainers_traditionalvskata_diagram.jpg)

Kata rely on higher level container runtime containerd and replace classic runc low lever runtime to manage container, see below :

![kata runtime](https://github.com/kata-containers/documentation/raw/master/design/arch-images/docker-kata.png)

## Sources 

- [Kata v1 (old) architecture](https://github.com/kata-containers/documentation/blob/master/design/architecture.md#kata-containers-architecture)
- [Kata latest documentation](https://github.com/kata-containers/kata-containers/tree/main/docs)