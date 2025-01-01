#  proxmox provider

## Install proxmox provider

There is at the writing time, no official terraform proxmox provider, but proxmox create a fork from "Telmate" terraform provider at [proxmox terraform provider](https://registry.terraform.io/providers/Terraform-for-Proxmox/proxmox/latest/docs)

- install terraform proxmox "Telmate" provider :
```shell
# Clone the repository
mkdir /tmp/terraform_provider_install
git clone https://github.com/Telmate/terraform-provider-proxmox /tmp/terraform_provider_install

#Run the Makefile (requires a working Goland installation)
cd /tmp/terraform_provider_install/
make

# Create the Terraform plugins directory and move the generated plugins to it
mkdir ~/.terraform.d/plugins
cp /tmp/terraform_provider_install/bin/terraform-provider-proxmox ~/.terraform.d/plugins
cp /tmp/terraform_provider_install/bin/terraform-provisioner-proxmox ~/.terraform.d/plugins

# Purge temp files
rm -r /tmp/terraform_provider_install
```

## Configure proxmox provider

Configure the credential to be use with proxmox API : [see related documentation](https://registry.terraform.io/providers/Terraform-for-Proxmox/proxmox/latest/docs#creating-the-proxmox-user-and-role-for-terraform).

- Configure user, role and privileges on proxmox :
```
pveum role add <proxmox_role_name_for_terraform> -privs "Datastore.AllocateTemplate Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"
pveum user add <proxmox_username_for_terraform>@pve --password <password>
pveum aclmod / -user <proxmox_username_for_terraform>@pve -role <proxmox_role_name_for_terraform>
pveum role modify <proxmox_role_name_for_terraform> -privs "Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"
```

- Finally set API for previous user :
```
pveum user token add packer@pve packer -expire 0 -privsep 0 -comment "Packer token"
```

## proxmox provider usage

See example below :
```
packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "debian-kickstart" {
  boot_command = [
    "<esc><wait>",
    "install <wait>",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
    "debian-installer=fr_FR.UTF-8 <wait>",
    "auto <wait>",
    "locale=fr_FR.UTF-8 <wait>",
    "kbd-chooser/method=fr <wait>",
    "keyboard-configuration/xkb-keymap=fr <wait>",
    "netcfg/get_ipaddress=${var.tpl_address} <wait>",
    "netcfg/get_netmask=${var.tpl_netmask} <wait>",
    "netcfg/get_gateway=${var.tpl_gtw} <wait>",
    "netcfg/get_nameservers=${var.tpl_dns} <wait>",
    "netcfg/disable_autoconfig=true <wait>",
    "netcfg/get_hostname=template <wait>",
    "netcfg/get_domain=${var.tpl_domain} <wait>",
    "fb=false <wait>",
    "debconf/frontend=noninteractive <wait>",
    "console-setup/ask_detect=false <wait>",
    "console-keymaps-at/keymap=fr <wait>",
    "grub-installer/bootdev=/dev/sda <wait>",
    "<enter><wait>"
  ]
    boot_wait = "10s"

    disks {
      disk_size         = "20G"
      storage_pool      = "data2"
      type              = "scsi"
      storage_pool_type = "lvm"
      format            = "raw"
    }
    disks {
      disk_size         = "50G"
      storage_pool      = "data2"
      type              = "scsi"
      storage_pool_type = "lvm"
      format            = "raw"
    }

    http_directory           = "http_dir"
    insecure_skip_tls_verify = true
    iso_file                 = "local:iso/debian-12.0.0-amd64-netinst.iso"

    network_adapters {
      bridge = "vmbr0"
      model  = "virtio"
      firewall = false
    }

    node                 = "prox"
    password             = "${var.password}"
    username             = "${var.username}"
    proxmox_url          = "${var.urlprox}"
    ssh_password         = "${var.sshpass}"
    ssh_username         = "${var.sshuser}"
    ssh_timeout          = "15m"
    vm_name              = "debian12"
    sockets              = 1
    cores                = 2
    memory               = 4096
    pool                 = "VM"
    template_description = "Debian 12 generated on ${timestamp()}"
    template_name        = "debian12"
    unmount_iso          = true
    cloud_init           = true
    cloud_init_storage_pool = "data2"
  }

  build {
    sources = ["source.proxmox-iso.debian-kickstart"]

    provisioner "ansible" {
      playbook_file = "./playbooks/template.yml"
      extra_arguments = ["--vault-password-file=passvault.txt", "--extra-vars", "ansible_ssh_pass=${var.sshpass}", "--extra-vars", "ansible_become_pass=${var.sshpass}"]
      keep_inventory_file = true
      use_proxy = false
      ansible_env_vars = ["ANSIBLE_HOST_KEY_CHECKING=False"]
    }
  }
```

## source :

- [official terraform proxmox provider](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs)
- [proxmox ISO builder documentation](https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox/latest/components/builder/iso)
- [Fix error " problem with client ::ffff:xxx.xxx.xxx.xxx; No space left on device"](https://forum.proxmox.com/threads/error-0-occured-while-receiving-the-doument-when-uploading-an-iso-as-pve-user.115796/#post-500878)