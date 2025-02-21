# init master

## Description

> Note : There are multiple method to init/configure a master node see [Installing Kubernetes with deployment tools](https://kubernetes.io/docs/setup/production-environment/tools/). This guide is ony focus on the simpliest methos which is kubeadm.

Describe how to init master using kubeadm.

- Make sure to install all element needed by kubernetes nodes :
    - container engine (docker) : [See documentation related to docker installation](https://docs.docker.com/engine/install/)
    - high level container runtime interface (CRI : CRI-O or containerd) : [see documentation related to containerd installation](https://containerd.io/downloads/)
    - low lever container runtime (runc) : [see documentation related to runc installation](https://github.com/opencontainers/runc/releases)
    
- Then install kubeadm bin on the master node :
    - kubeadm : [See documentation related to kubeadm installation](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/).

- Then init the master node (on the master node) :
```
kubeadm init
```

Now the master is ready to accept connection from worker nodes.


## Sources :

- [create a master using kubeadm](https://kubernetes.io/fr/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)