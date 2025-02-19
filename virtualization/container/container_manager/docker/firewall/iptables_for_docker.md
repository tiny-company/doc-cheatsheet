# iptables for docker

## How docker work with firewall

### iptables Chains usage in docker

Docker uses iptables to implement its network isolation and port forwarding features. Here's a simplified scheme illustrating the key chains involved in Docker networking:

```plaintext
                         +---------------------+
                         |    FORWARD chain    |
                         +---------------------+
                                 |
                                 V
                         +---------------------+
                         |   DOCKER chain      |
                         +---------------------+
                                 |
                +--------------+ |
                | DOCKER-USER  | |
                +--------------+ |
                                 |
                                 V
                         +---------------------+
                         | DOCKER-ISOLATION    |
                         |    (Bridge mode)    |
                         |    (optional)       |
                         +---------------------+
                                 |
                                 V
                         +---------------------+
                         |   nat/PREROUTING    |
                         +---------------------+
                                 |
                                 V
                         +---------------------+
                         | nat/OUTPUT          |
                         +---------------------+
```

Explanation of the chains:

1. **FORWARD chain:**
   - This is the main iptables chain responsible for forwarding packets between interfaces, including Docker containers.

2. **DOCKER chain:**
   - Docker inserts rules in the `FORWARD` chain to match packets related to Docker containers. It is responsible for directing Docker-related traffic to the appropriate user-defined chains.

3. **DOCKER-USER chain:**
   - The `DOCKER-USER` chain is the primary chain for user-defined iptables rules. Docker recommends using this chain for customization to avoid interfering with Docker's default behavior. It is called from the `DOCKER` chain, allowing users to add additional rules.

4. **DOCKER-ISOLATION chain:**
   - The `DOCKER-ISOLATION` chain is used in bridge mode to implement network isolation between containers. It helps ensure that traffic between containers is controlled.

5. **nat/PREROUTING chain:**
   - This chain is part of the NAT (Network Address Translation) table and is used for packet modifications before routing. Docker inserts rules here for port forwarding and exposing container services to the host or external network.

6. **nat/OUTPUT chain:**
   - Similar to `nat/PREROUTING`, this chain is responsible for modifying locally generated packets before routing. Docker may insert rules here for cases where the container initiates outgoing connections.

These chains work together to implement Docker's networking features. The `DOCKER` chain directs traffic to `DOCKER-USER` for user-defined rules, and `DOCKER-ISOLATION` helps enforce container isolation. The NAT chains (`nat/PREROUTING` and `nat/OUTPUT`) are used for port forwarding and exposing container services.

### DOCKER

It contains rules that control incoming traffic to Docker containers.  It is generated and updated/managed by docker daemon. Do not edit this chain as it will be erased by docker daemon, see below [DOCKER-USER](#docker-user-chain) chain.

### DOCKER-USER chain

On Linux, Docker manipulates iptables rules to provide network isolation

Docker installs two custom iptables chains named DOCKER-USER and DOCKER, and it ensures that incoming packets are always checked by these two chains first. These chains are part of the FORWARD chain.

Using classic rules with INPUT table won't work, your containers are still accessible for everyone. Indeed, Docker containers are not host services. They rely on a virtual network in your host, and the host acts as a gateway for this network. And concerning gateways, routed traffic is not handled by the INPUT table, but by the FORWARD table, which makes the rule posted before uneffective.

All of Docker's iptables rules are added to the DOCKER chain. Do not manipulate this chain manually. If you need to add rules which load before Docker's rules, add them to the DOCKER-USER chain. These rules are applied before any rules Docker creates automatically.

Other rules added to the FORWARD chain, either manually, or by another iptables-based firewall, are evaluated after the DOCKER-USER and DOCKER chains. This means that if you publish a port through Docker, this port gets published no matter what rules your firewall has configured. If you want rules to apply even when a port gets published through Docker, you must add these rules to the DOCKER-USER chain.

#### Firewall script example

- find a shell script to apply firewall rules :
```shell
#!/bin/sh

## ================================================
## Get external interface
## ================================================

get_external_interface() {
    gateway_ip=$(ip route show default | awk '/default/ {print $3}')
    # Use the default gateway IP address to determine the external interface
    EXT_IF=$(ip route get $gateway_ip | awk '/dev/ {print $3}')
}
get_external_interface || echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR : $?"

## ================================================
## Manage host firewall with INPUT table
## ================================================

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 53 -j ACCEPT
iptables -A INPUT -p udp -m udp --sport 123 -j ACCEPT
iptables -A INPUT -s 51.15.223.6/32 -m comment --comment vpn -j ACCEPT
iptables -A INPUT -s 109.190.117.17/32 -m comment --comment valmy2 -j ACCEPT
iptables -A INPUT -s 51.159.76.2/32 -m comment --comment maven -j ACCEPT
iptables -A INPUT -s 51.159.79.244/32 -m comment --comment jenkins -j ACCEPT
iptables -A INPUT -p icmp -m icmp --icmp-type 8 -m comment --comment "block icpm" -j DROP
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -j DROP

## ================================================
## Manage docker firewall with DOCKER-USER table
## ================================================

## Limit host access to one IP and drop rest (Match the original IP and ports for requests)
iptables -I DOCKER-USER 1 -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -I DOCKER-USER 2 -p tcp -m conntrack --ctorigsrc 51.15.223.6 -m comment --comment 'docker allow from vpn' -j ACCEPT
iptables -I DOCKER-USER 3 -p tcp -m conntrack --ctorigsrc 109.190.117.17 -m comment --comment 'docker allow from valmy2' -j ACCEPT
iptables -I DOCKER-USER 4 -i ${EXT_IF} -j DROP
iptables -I DOCKER-USER 5 -j RETURN

## ================================================
## Backup old rules and save new rules
## ================================================

cp /etc/iptablesRule.v4 /etc/iptablesRule.v4.bak
iptables-save > /etc/iptablesRule.v4
```

> Important note :
- Don't forget to drop all from external interface in the docker-user chain using : `iptables -A DOCKER-USER -i ${EXT_IF} -j DROP`
- Don't forget to return to previous chain at the end of the docker-user chain (to the FORWARD chain) using : `iptables -A DOCKER-USER -j RETURN`.

### DOCKER-ISOLATION-STAGE-1

Find below the classic content of the "DOCKER-ISOLATION-STAGE-1" chain (generated by docker) :
```
-A DOCKER-ISOLATION-STAGE-1 -i docker0 ! -o docker0 -j DOCKER-ISOLATION-STAGE-2
-A DOCKER-ISOLATION-STAGE-1 -i br-cbeb3435354c ! -o br-cbeb3435354c -j DOCKER-ISOLATION-STAGE-2
-A DOCKER-ISOLATION-STAGE-1 -j RETURN
```

Explanation of theses rules and the DOCKER-ISOLATION-STAGE-1 utility :

- Packets coming from  docker0 interface to be sent via anything but docker0 interface are send to DOCKER-ISOLATION-STAGE-2 chain (from container via outside interface, allow egress traffic)
- Packet coming from bridge interface to be sent via anything but bridge interface are send to DOCKER-ISOLATION-STAGE-2 chain
- Go backs (return) to previous chain (forward), next chain in forward is '

In its default state, DOCKER-ISOLATION-STAGE-1 doesn’t seem to do much but rules can be added via container configuration to enforce traffic restrictions for containers.

### DOCKER-ISOLATION-STAGE-2

Find below the classic content of the "DOCKER-ISOLATION-STAGE-2" chain (generated by docker) :
```
-A DOCKER-ISOLATION-STAGE-2 -o docker0 -j DROP
-A DOCKER-ISOLATION-STAGE-2 -o br-cbeb3435354c -j DROP
-A DOCKER-ISOLATION-STAGE-2 -j RETURN
```

Explanation of theses rules and the DOCKER-ISOLATION-STAGE-2 utility :

- drop packet from docker0 interface
- drop packet from bridge interface


In its default state, DOCKER-ISOLATION-STAGE-2 doesn’t seem to do much but rules can be added via container configuration to enforce traffic restrictions for containers.

## understand docker isolation

Isolation stage 1 will send any container-originating traffic that is not destined to the same container to stage 2.
The stage 2 will reject any traffic targeting a container.

So, in effect, stage 1+2 prevents containers on different docker networks to communicate with each other (but allows containers to communicate with the outside world, at this point).


## Sources :

- [Best article to explain docker and iptables](https://blog.geekodour.org/posts/iptables_and_docker/)
- [old article about iptables with docker](https://www.grottedubarbu.fr/docker-firewall/)
- [tutorial about iptables with docker](https://riptutorial.com/docker/topic/9201/iptables-with-docker)
- [serverfault topic about iptables with docker](https://serverfault.com/questions/946010/what-are-proper-iptables-rules-for-docker-host)
- [docker official documentation about firewalling](https://docs.docker.com/network/packet-filtering-firewalls/)
- [iptables example script to configure docker iptables](https://gist.github.com/blockpane/600b988e3d0d79a1bf668a763d8379c9)
- [iptables and ufw for docker (good graph)](https://richincapie.medium.com/docker-ufw-and-iptables-a-security-flaw-you-need-to-solve-now-40c85587b563)