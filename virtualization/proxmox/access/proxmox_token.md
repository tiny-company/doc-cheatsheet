# proxmox token access

## generate proxmox token for user

- generate new token for user "terraform" :
```
pveum user token add terraform@pve terraform -expire 0 -privsep 0 -comment "Terraform token"
```