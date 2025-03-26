# Troubleshooting lockout rule

## Description

This document give information to troubleshoot wrong action that lead to pfsense lockout (cannot reach pfsense).

## disable firewall rules 

- To disable firewall rules : 
```
pfctl -d
```

- To reactive firewall rules : 
```
pfctl -e
```

- [More of pfctl command syntax](https://www.openbsdhandbook.com/pf/cheat_sheet/)

> Note : This completely disables pf which disables firewall rules and NAT. If the network run by this firewall relies on NAT to function, which most do, then running this command will disrupt connectivity from the LAN to the Internet.

## Source : 

- [official pfsense documentation about troubleshooting lockout](https://docs.netgate.com/pfsense/en/latest/troubleshooting/locked-out.html)