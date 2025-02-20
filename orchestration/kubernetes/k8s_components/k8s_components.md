# kubernetes component

- Master components :
    - [API server](#api-server)
    - [Controller Manager](#controller-manager)
    - [etcd](#etcd)
    - [scheduler component](#scheduler-component)

- Nodes components :
    - [Kubelet](#kubelet)
    - [kube-proxy](#kube-proxy)
    - [container runtime](#cr-container-runtime)

![k8s_architecture](https://kubernetes.io/images/docs/kubernetes-cluster-architecture.svg)

## Master components (control plane)

The control plane's components make global decisions about the cluster (for example, scheduling), as well as detecting and responding to cluster events (for example, starting up a new pod when a Deployment's replicas field is unsatisfied).

Control plane components can be run on any machine in the cluster. However, for simplicity, setup scripts typically start all control plane components on the same machine, and do not run user containers on this machine.

### API server

The API server is a component of the Kubernetes control plane that exposes the Kubernetes API. The API server is the front end for the Kubernetes control plane.

The main implementation of a Kubernetes API server is kube-apiserver. kube-apiserver is designed to scale horizontally—that is, it scales by deploying more instances. You can run several instances of kube-apiserver and balance traffic between those instances.

[k8s documentation about kube-apiserver](https://kubernetes.io/docs/concepts/architecture/#kube-apiserver)

### Controller Manager 

Control plane component that runs controller processes.

Logically, each controller is a separate process, but to reduce complexity, they are all compiled into a single binary and run in a single process.

There are many different types of controllers. Some examples of them are:

- Node controller: Responsible for noticing and responding when nodes go down.
- Job controller: Watches for Job objects that represent one-off tasks, then creates Pods to run those tasks to completion.
- EndpointSlice controller: Populates EndpointSlice objects (to provide a link between Services and Pods).
- ServiceAccount controller: Create default ServiceAccounts for new namespaces.

[k8s documentation about kube-controller-manager](https://kubernetes.io/docs/concepts/architecture/#kube-controller-manager)

### etcd

Consistent and highly-available key value store used as Kubernetes' backing store for all cluster data.

If your Kubernetes cluster uses etcd as its backing store, make sure you have a back up plan for the data.

You can find in-depth information about etcd in the official documentation.

[k8s documentation about etcd](https://kubernetes.io/docs/concepts/architecture/#etcd)

### scheduler component 

Control plane component that watches for newly created Pods with no assigned node, and selects a node for them to run on.

Factors taken into account for scheduling decisions include: individual and collective resource requirements, hardware/software/policy constraints, affinity and anti-affinity specifications, data locality, inter-workload interference, and deadlines.

[k8s documentation about kube-scheduler](https://kubernetes.io/docs/concepts/architecture/#kube-scheduler)

## Nodes components

Node components run on every node, maintaining running pods and providing the Kubernetes runtime environment.
kubelet.

[k8s documentation about nodes](https://kubernetes.io/docs/concepts/architecture/nodes/)

### Kubelet

An agent that runs on each node in the cluster. It makes sure that containers are running in a Pod.

The kubelet takes a set of PodSpecs that are provided through various mechanisms and ensures that the containers described in those PodSpecs are running and healthy. The kubelet doesn't manage containers which were not created by Kubernetes.

[k8s documentation about kubelet](https://kubernetes.io/docs/concepts/architecture/#kubelet)

### kube-proxy

kube-proxy is a network proxy that runs on each node in your cluster, implementing part of the Kubernetes Service concept.

kube-proxy maintains network rules on nodes. These network rules allow network communication to your Pods from network sessions inside or outside of your cluster.

kube-proxy uses the operating system packet filtering layer if there is one and it's available. Otherwise, kube-proxy forwards the traffic itself.
If you use a network plugin that implements packet forwarding for Services by itself, and providing equivalent behavior to kube-proxy, then you do not need to run kube-proxy on the nodes in your cluster.

[k8s documentation about kube-proxy](https://kubernetes.io/docs/concepts/architecture/#kube-proxy)

### CR (container runtime)

A fundamental component that empowers Kubernetes to run containers effectively. It is responsible for managing the execution and lifecycle of containers within the Kubernetes environment.

Kubernetes supports container runtimes such as containerd, CRI-O, and any other implementation of the Kubernetes CRI (Container Runtime Interface). Look at [this article to learn more about CR, CRI, container shim relation](https://iximiuz.com/en/posts/journey-from-containerization-to-orchestration-and-beyond/) 

[k8s documentation about container runtime](https://kubernetes.io/docs/concepts/architecture/#container-runtime)