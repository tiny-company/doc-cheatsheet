# iptables

## Basics

- How work iptables commands ?

Iptables is used to set up, maintain, and inspect the tables of IP packet filter rules in the Linux kernel. Several different tables may be defined. Each table contains a number of built-in chains and may also contain user-defined chains.

To resume the iptables principes :

rules = Table > chain > target

![iptables working image](https://phoenixnap.com/kb/wp-content/uploads/2021/04/iptables-diagram.png)

### Table :

table : table specifies the packet matching table which the command should operate on (There are currently five independent tables (which tables are present at any time depends on the kernel configuration options and which modules are present).

Each table ontains a number of built-in chains and may also contain user-defined chains.

Find below all the tables available (except the security one) :

#### Filter :

The Filter table is the most frequently used one and also the default table (if no -t option is passed). It acts as a bouncer, deciding who gets in and out of your network. It has the following default chains:

- Input : the rules in this chain control the packets received by the server.
- Output : this chain controls the packets for outbound traffic.
- Forward : this set of rules controls the packets that are routed through the server.

#### Nat :

This table contains NAT (Network Address Translation) rules for routing packets to networks that cannot be accessed directly. When the destination or source of the packet has to be altered, the NAT table is used. It includes the following chains:

- Prerouting : this chain assigns packets as soon as the server receives them.
- Output : works the same as the output chain we described in the filter table.
- Postrouting : the rules in this chain allow making changes to packets after they leave the output chain.

#### Mangle :

The Mangle table adjusts the IP header properties of packets. The table has all the following chains we described above:

- Prerouting
- Postrouting
- Output
- Input
- Forward

#### Raw : This table is used mainly for configuring exemptions from connection tracking in combination with the NOTRACK target. It registers at the netfilter hooks with higher priority and is thus called before ip_conntrack, or any other IP tables. The Raw table is used to exempt packets from connection tracking. The raw table has two of the chains we previously mentioned:

- Prerouting
- Output

Find below a example of tables usage with the adding cmd :
```
iptables [-t table] -[AD] chain rule-specification [options]
```

> Note : most of the time, we do not change the table when configuring iptables as filtering is the main action (nat is the second most used)

### Chain :

A chain is a string of rules. When a packet is received, iptables finds the appropriate table, then runs it through the chain of rules until it finds a match.
The chain depend on the table but for an example for the filter table which is the most used, you could have these chains :
- Input : the rules in this chain control the packets received by the server.
- Output : this chain controls the packets for outbound traffic.
- Forward : this set of rules controls the packets that are routed through the server.

### Target :

A firewall rule specifies criteria for a packet and a target.  If the packet does not match, the next rule in the chain is examined; if it does match, then the next rule is specified by the value of the target, which can be the name of a user-defined chain, one of the targets described in iptables-extensions(8), or one of the special values ACCEPT, DROP or RETURN

To resume the previous explanation from the official manual : target are keyword that describe what happen to the packet next (accept it, drop it, put it in a queu or return it)

find below an example of target keyword :
```
ACCEPT, DROP, QUEUE, RETURN.
```

- ACCEPT means to let the packet through.
- DROP means to drop the packet on the floor. the dropped package is not matched against any further chain. When Linux iptables drop an incoming connection to your server, the person trying to connect does not receive an error. It appears as if they are trying to connect to a non-existing machine.
- QUEUE means to pass the packet to userspace.
- REJECT is used to send back an error packet in response to the matched packet: otherwise it is equivalent to DROP so it is a terminating TARGET, ending rule traversal
- RETURN means stop traversing this chain and resume at the next rule in the previous (calling) chain. If the end of a built-in chain is reached or a rule in a built-in chain with target RETURN is matched, the target specified by the chain policy determines the fate of the packet. This is particularly useful when you want to apply certain actions to packets and then return to the original chain without processing further rules

See below more details about `RETURN` target is it can be complicated to understand :

#### Example of RETURN usage :

- RETURN rule with no destination (value) :
```
iptables -A INPUT -p tcp --dport 22 -j RETURN
```

In this example, if the packet matches the specified conditions (TCP protocol and destination port 22), the RETURN target is triggered, and the evaluation returns to the calling chain.

- RETURN rule with destination (value) :

The RETURN target is often used in conjunction with user-defined chains. You can create a user-defined chain, add rules to it, and then use the RETURN target to exit the chain and return to the calling chain. It can be seen as a redirection rule that transfert packet management to another chain.
```
iptables -N MY_CHAIN
iptables -A INPUT -p tcp --dport 80 -j MY_CHAIN
iptables -A MY_CHAIN -s 192.168.1.1 -j RETURN
iptables -A MY_CHAIN -j ACCEPT
```

#### Common use case for RETURN

One common use case is when you have a set of conditions that, if met, should skip the remaining rules in a chain. Instead of duplicating those conditions in each subsequent rule, you can use the RETURN target.

The RETURN target is also used in conjunction with custom rule processing in user-defined chains, allowing for more modular and organized rule sets.

### Rule :

Each rule specifies what to do with a packet that matches.

A rule is a statement that tells the system what to do with a packet. Rules can block one type of packet, or forward another type of packet. The outcome, where a packet is sent, is called a target.

Find below an example of a rule :
```
sudo iptables -A INPUT -i lo -j ACCEPT
```

- "-j" stand for "jump" and it define the target (ACCEPT, DROP, etc ...)
- "-A" stand for "adding" it define what to do with the define rule (add, delete, insert, etc...)

## view commmands

### show rules

Let’s look at how to list rules first. There are two different ways to view your active iptables rules: in a table or as a list of rule specifications. Both methods provide roughly the same information in different formats.

- To list out all of the active iptables rules by specification, run the iptables command with the -S option:
```
sudo iptables -S
```

This will show iptables as command input (see below an output example):

```
Output
-P INPUT DROP
-P FORWARD DROP
-P OUTPUT ACCEPT
-N ICMP
-N TCP
-N UDP
-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m conntrack --ctstate INVALID -j DROP
-A INPUT -p udp -m conntrack --ctstate NEW -j UDP
-A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -m conntrack --ctstate NEW -j TCP
-A INPUT -p icmp -m conntrack --ctstate NEW -j ICMP
-A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
-A INPUT -p tcp -j REJECT --reject-with tcp-reset
-A INPUT -j REJECT --reject-with icmp-proto-unreachable
-A TCP -p tcp -m tcp --dport 22 -j ACCEPT
```

- Listing Rules as Tables (-L --list):
```
sudo iptables -L
```

- Other options :
    - "-v --verbose" : Show more information when using a list option.
    - "-C --check" : Look for a rule that matches the chain’s requirements.

- Another option that can be usefull is the line number (if inserting rules) :
```
iptables -L --line-numbers -n
```

### Check rule existence

- check if a rule exist in a specified chain :
```
iptables -t filter --check INPUT -s 192.168.1.123 -j DROP
```

## adding / inserting / updating / replace  commands

- adding a new rule (append a rule at the bottom of the list):
```
iptables -t filter -A INPUT -p udp -j DROP
```

- insert a new rule (insert the rule at the specified row):
```
sudo iptables -I INPUT 1 -i eth0 -j ACCEPT
```

- replace a rule by an other (at the specified row) :
```
iptables -R INPUT [line number] -p tcp -m state --state NEW --dport 22 -s [new IP address] -j ACCEPT
```

"-R, --replace" chain rulenum rule-specification
Replace a rule in the selected chain. If the source and/or destination names resolve to multiple addresses, the command will fail. Rules are numbered starting at 1.

## deleting  rules

**Important note : When working with firewalls, take care not to lock yourself out of your own server by blocking SSH traffic (port 22, by default). If you lose access due to your firewall settings, you may need to connect to it via a web-based console to fix your access. But the user or root password in not set by default on cloud instance, so be carefull to be sure about that you can log with password on a machine**

- Set default policy to Accept :
```
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
```
> Note : Before flushing rules, make sure that the default policy is set to ACCEPT or everything will be blocked after flushing


- flush all rules (-F --flush) :
```
sudo iptables -F
```

- deleting a rule from it's position :
```
sudo iptables -D INPUT <Number>
```

- deleting a rule from it's definition :
```
iptables -D INPUT -s xxx.xxx.xxx.xxx -j DROP
```


## Saving Rules


Iptables rules are ephemeral, which means they need to be manually saved for them to persist after a reboot.

On Ubuntu, one way to save iptables rules is to use the iptables-persistent package. Install it with apt like this:
```
sudo apt install iptables-persistent
```
During the installation, you will be asked if you want to save your current firewall rules.

If you update your firewall rules and want to save the changes, run this command:
```
sudo netfilter-persistent save
```
Other Linux distributions may have alternate ways of making your iptables changes permanent. Please refer to the relevant documentation for more information.

## usefull rules

- accept local traffic (localhost) :
```
sudo iptables -A INPUT -i lo -j ACCEPT
```

"-i" specify the interface

- accept http traffic from request from 192.168.0.27 :
```
sudo iptables -A INPUT -p tcp --dport 443 -s 192.168.0.27 -j ACCEPT
```

"-s" - stand for "source" it define the source address of the packet
"-p" – Check for the specified protocol (tcp).
"--dport" – Specify the destination port.
"-j jump" – Take the specified action (the target)

- apply rule on multiple port :

Solution 1 : using match multiport
```
iptables -A INPUT -p tcp -i eth0 -m multiport --dports 465,110,995,587,143,11025,20,21,22,26,80,443 -j ACCEPT
iptables -A INPUT -p tcp -i eth0 -m multiport --dports 3000,10000,7080,8080,3000,5666 -j ACCEPT
```

Solution 2 : using range format
```
iptables -A INPUT -p tcp -i eth0 --dports 20:11025 -j ACCEPT
```
see more at [Useful Rules from digitalocean tutorial](https://www.digitalocean.com/community/tutorials/iptables-essentials-common-firewall-rules-and-commands#generally-useful-rules)

## Common default rules

- Allow loopback connections :
```
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
```

- Allow incoming connection already established :
```
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
```

- Allow outgoing connection already established :
```
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT
```

- Allow ssh from a specific IP address :
```
iptables -A INPUT -p tcp -s 203.0.113.0/24 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
```
iptables -A  INPUT -s 51.159.76.2/32 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

## Sources :

- [very good tutorial about iptable](https://phoenixnap.com/kb/iptables-tutorial-linux-firewall)
-[digitalocean  iptables tutoriel](https://www.digitalocean.com/community/tutorials/iptables-essentials-common-firewall-rules-and-commands)
-[iptables man](https://linux.die.net/man/8/iptables)