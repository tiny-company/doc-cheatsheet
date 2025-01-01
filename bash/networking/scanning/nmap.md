# nmap

## Description

- ping scan (find ip that respond to ping)
```
nmap -sp <target ip or fqdn>
```

- basic (and default) scan (scan 1000 first ports)
```
nmap <target ip or fqdn>
```

- Aggressive scan (give a lot of information but very noisy):
```
nmap -A <target ip or fqdn>
```

- Stealth scan (slow but less visible scan)
```
nmap -sS <target ip or fqdn>
```

- Version scanning (give the protocol version):
```
nmap -sV <target ip or fqdn>
```

- Specific port scanning :
```
nmap -p 973 <target ip or fqdn>
```