# proxmox network configuration

Proxmox is using the linux network stack. The network configuration can be done with the classic linux network configuration file (/etc/network/interfaces) or via the proxmox GUI.

## linux network configuration file

Follow the [netwokr interface manual](https://manpages.debian.org/bookworm/ifupdown2/interfaces.5.en.html) to configure the file.

To apply the configuration made through the file run :
```
ifreload -a
```

## Sources :

- [proxmox network configuration official documentation](https://pve.proxmox.com/pve-docs/pve-admin-guide.html#sysadmin_network_configuration)