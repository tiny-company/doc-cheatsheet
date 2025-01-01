# Nftables 

## Description

Nftables is a packet classification framework that aims to replace the existing iptables, ip6tables, arptables and ebtables facilities. It aims to resolve a lot of limitations that exist in the venerable ip/ip6tables tools. 

From a user point of view, nftables adds a new tool, called nft, which replaces all other tools from iptables, arptables and ebtables. From an architectural point of view it also replaces those parts of the kernel that deal with run-time evaluation of the packet filtering rule set. 

## Usefull commands

- list ruleset :
```
nft list ruleset
```

- clear ruleset :
```
nft flush ruleset
```


## Sources : 

- [reference-nftables](https://wiki.nftables.org/wiki-nftables/index.php/Quick_reference-nftables_in_10_minutes)
- [What comes after 'iptables'? Its successor: `nftables`](https://developers.redhat.com/blog/2016/10/28/what-comes-after-iptables-its-successor-of-course-nftables#)
- [Getting started with nftables](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/getting-started-with-nftables_configuring-and-managing-networking)