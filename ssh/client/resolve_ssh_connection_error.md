# resolve ssh connection error (from client)

It can happen that on old equipement (often on switch, router) the ssh server don't have up to date connection parameters (or old method disable by default on recent client), to force usage of old parameters use the "-o" arg on ssh command (see more below) 

## no matching key exchange method found

- Use option "KexAlgorithms" to specify the parameters allowed by the server (this can be seen on the connection error message) :
```
ssh <ip> -l <user> -p <ssh_port> -oKexAlgorithms=+diffie-hellman-group14-sha1
```

## no matching host key type found

- Use option "HostKeyAlgorithms" to specify the parameters allowed by the server (this can be seen on the connection error message) :
```
ssh <ip> -l <user> -p <ssh_port> -oHostKeyAlgorithms=+ssh-rsa
```