# Quick Tips for Proxmox installation and usage

## Quick tips after first installation

- Disable message "You do not have valid subscription"

change `status => "notfound",` to `status => "active",`  in "/usr/share/perl5/PVE/API2/Subscription.pm" file and restart pve-proxy with `systemctl restart pveproxy.service`

- [Put the machine proxmox in NAT](https://www.linuxtricks.fr/wiki/wiki.php?title=proxmox-quelques-infos)

- [How To Revert a Proxmox Kernel Update](https://engineerworkshop.com/blog/how-to-revert-a-proxmox-kernel-update/)