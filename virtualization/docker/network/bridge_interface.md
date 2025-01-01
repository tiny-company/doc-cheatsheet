# docker bridge interface

## docker0 virtual interface

When Docker is installed, it automatically creates a virtual Ethernet bridge named docker0 on the host system. This bridge acts as the default bridge network for Docker containers.

When a container is started, Docker connects it to the docker0 bridge by default. This allows the container to communicate with the host system and with other containers connected to the same bridge.

Each container connected to the docker0 bridge is assigned an IP address within the bridge's IP address range. The bridge itself has an IP address, typically acting as the default gateway for the containers.

The docker0 bridge facilitates routing and packet forwarding between containers on the same bridge network. Containers can communicate with each other directly using their assigned IP addresses.

For communication with the external network (outside the host), Docker uses a process known as "Network Address Translation" (NAT). The docker0 bridge performs NAT to allow containers to share the host's IP address when communicating with external resources. Docker uses iptables to set up rules for Network Address Translation (NAT) to enable communication between containers and the external network. These rules modify the source and destination addresses of packets to allow them to traverse the bridge interface and reach external destinations.

Docker uses iptables to implement port mapping and forwarding. When you publish a container's port to the host using the -p option, iptables rules are created to forward traffic from the host's port to the corresponding port inside the container.

Docker also uses iptables to implement security group rules. These rules control incoming and outgoing traffic to and from containers based on user-defined policies. Docker provides a convenient way to manage these rules through the docker network and docker run commands.

Docker dynamically generates iptables rules based on container creation and network configuration. These rules are managed by Docker and are automatically updated when containers are started, stopped, or when their network configuration changes.