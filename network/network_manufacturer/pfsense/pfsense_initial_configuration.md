# Pfsense initial congiguration

## Description

This document describe how to configure pfsense at start (on hosted private cloud).

## 0. Follow console wizard

After setting an Pfsense iso under a disk connected at start (for hosted private cloud). Pfsense setup configuration menu appear on the console : 
- follow the initial wizard configuration to install pfsense on main disk.

After this step pfsense restart on the main disk instead if the mounted installation CD.

## 1. Set ip address

 Set a WAN interface which will be the main one (by convention also the one connected to "outside") :
- ip address
- network mask
- default gateway

After that Step, the pfsense web panel will be accessible with default credential :
- login : admin
- password : pfsense

> Note : Beware, if your WAN main interface is connected to internet, pfsense will be available on it with default credential, change them quickly to avoid any security issue.

## 2. Change default credential

After connection to the pfsense web interface with admin default credential, change the password :
- Go to System / User manager / Users
- Change admin password

## 3. Follow the setup wizard

At initial connection, a setup wizard assist the configuration : 
- Setting General information :
    - DNS address :
        - primary dns : 1.1.1.1 (Cloudflare)
        - secondary dns : 213.186.33.99 (OVH)
    - Hostname and domain name

- Setting NTP information :
    - ntp server : [find French NTP at this link](https://services.renater.fr/ntp/serveurs_francais), default OVH ntp server is "ntp0.ovh.net"
    - Timezone : Europe/paris

- (Re)configure Wan interface : 
    - ip address 
    - netmask
    - Default gateway : 

- (Re)set admin password 

## 4. Configure additional interface 

- [Pfsense official guide interface configuration](https://docs.netgate.com/pfsense/en/latest/config/interface-configuration.html)

## Source : 

- [Pfsense official startup documentation](https://docs.netgate.com/pfsense/en/latest/config/)
- [Pfesnse initial configuration tutorial](https://infosecwriteups.com/pfsense-first-install-and-configuration-869f8508e087)