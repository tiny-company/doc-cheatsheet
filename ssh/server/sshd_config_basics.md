# sshd_config basics

## Description 

This file describe some parameters of the config file "/etc/sshd/sshd_config" use to configure ssh server connection.

## Restrict user access

- to restrict ssh server access to specific user : 
``` 
AllowUsers <User1> <User2>
``` 

## Restrict group access

- to restrict ssh server access to specific group : 
``` 
AllowGroups <group>
``` 

## Use public key

- uncomment the line to be able to use public key authentication : 
``` 
#PubkeyAuthentication yes
``` 

- to force public key usage only (disable password authentication), edit line below and set "no"
``` 
# To disable tunneled clear text passwords, change to no here!
PasswordAuthentication no
``` 

- to deny root login, comment line below : 
```
PermitRootLogin prohibit-password
```

## Group configuration

- Create specific restriction per group :
```
Match Group ansible,monitor
  PasswordAuthentication no
```