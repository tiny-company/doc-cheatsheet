# ip set 

## Description 

Ip set is a tool to manage ip list on linux kernel.
We can use it in addition to iptables in order to apply firewall rules on list 

## Usage 

Below an example of ipset usage with iptables to allow all cloudflare ip range :

- Create the ipset chain : 
```
ipset create cloudflare_whitelist hash:net
```

See the set Types on the [documentation](https://linux.die.net/man/8/ipset)

- Add element to the ipset chain
```
ipset add cloudflare_whitelist 173.245.48.0/20
ipset add cloudflare_whitelist 103.21.244.0/22
ipset add cloudflare_whitelist 103.22.200.0/22
ipset add cloudflare_whitelist 103.31.4.0/22
ipset add cloudflare_whitelist 141.101.64.0/18
ipset add cloudflare_whitelist 108.162.192.0/18
ipset add cloudflare_whitelist 190.93.240.0/20
ipset add cloudflare_whitelist 188.114.96.0/20
ipset add cloudflare_whitelist 197.234.240.0/22
ipset add cloudflare_whitelist 198.41.128.0/17
ipset add cloudflare_whitelist 162.158.0.0/15
ipset add cloudflare_whitelist 104.16.0.0/13
ipset add cloudflare_whitelist 104.24.0.0/14
ipset add cloudflare_whitelist 172.64.0.0/13
ipset add cloudflare_whitelist 131.0.72.0/22
```

- Use the ipset in iptables rules :
```
iptables -I INPUT -m set --match-set cloudflare_whitelist src --comment cloudflare_whitelist -p tcp -m multiport --dports http,https -j ACCEPT
```

## Sources : 

- [how to use ipset on linux tutorial](https://www.malekal.com/comment-utiliser-ipset-sur-linux/)