# configure sudo 

## Description

This file describes the sudo configuration through config file "/etc/sudoers"

## Sudo file explain 

sudo config file content look like this :
```
user ALL = (user) command1,command2,...
%groupe ALL = (user) command1,command2,...
```

Where :
- user/group : is the username (or the group) on which the sudo right will be applied
- ALL : is the system on which the sudo rights will be applied
- (user) : is the user from which we will take the rights
- command : are the commands available to this user/group when sudo (use ALL for all command)

## Use sudo without password

- example to allow debian user to sudo without password :
```
debian ALL=(ALL) NOPASSWD: /usr/sbin/service
```

## Source : 

- [sudo configuration tutorial](https://www.linuxtricks.fr/wiki/sudo-utiliser-et-parametrer-sudoers)