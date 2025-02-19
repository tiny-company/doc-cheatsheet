# create a new user for terraform on proxmox

## Description

Procedure to create a new user (and role) for terraform usage on proxmox

- First Create a new role if not already done :
```shell
pveum role add OpentofuRole -privs "Datastore.Allocate Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Console VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"
```

The rights are the minimal one for virtual machine (and container) management.

- Then create a new user :
```shell
pveum user add opentofu-user@pve --password <password>
```

- Assign previously created role to this new user :
```shell
pveum aclmod / -user opentofu-user@pve -role OpentofuRole
```

- Generate a proxmox token for this user (this token will be used by terraform) :
```shell
pveum user token add opentofu-user@pve opentofu -expire 0 -privsep 0 -comment "opentofu token"
```

Full procedure in combined line :
```shell
TERRAFORM_USER_PASSWORD="passtochange"
pveum role add OpentofuRole -privs "Datastore.Allocate Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Console VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"
pveum user add opentofu-user@pve --password ${TERRAFORM_USER_PASSWORD}
pveum aclmod / -user opentofu-user@pve -role OpentofuRole
pveum user token add opentofu-user@pve opentofu -expire 0 -privsep 0 -comment "opentofu token"
```