# init worker

## Desription

Procedure to init a kubernetes worker node using `kubeadm` method.

- Make sure to install all element needed by kubernetes nodes :
    - container engine (docker) : [See documentation related to docker installation](https://docs.docker.com/engine/install/)
    - high level container runtime interface (CRI : CRI-O or containerd) : [see documentation related to containerd installation](https://containerd.io/downloads/)
    - low lever container runtime (runc) : [see documentation related to runc installation](https://github.com/opencontainers/runc/releases)
    
- Then install kubeadm on the worker node :
    - kubeadm : [See documentation related to kubeadm installation](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/).
    - kubectl : see documentation for kubeadm
    - kubelet : see documentation for kubeadm
