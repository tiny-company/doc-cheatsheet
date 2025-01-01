# install proxmox provider

There is at the writing time, no official terraform proxmox provider.

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

## source :

- [official terraform proxmox provider](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs)