# cloud init virtual machine template

To create a virtual machine template compatible with cloud-init :

- First, get the cloud-init compatible iso (exemple with debian 12) :
```
curl -O https://laotzu.ftp.acc.umu.se/images/cloud/bookworm/20240717-1811/debian-12-genericcloud-amd64-20240717-1811.qcow2 --output-dir /var/lib/vz/template/iso
```

- Then, create a VM template in proxmox :
```shell
# Create the instance
qm create <vm_id> -name debian_12-cloudinit -memory 2048 -net0 virtio,bridge=vmbr1 -cores 3 -sockets 1
# Import the OpenStack disk image to Proxmox storage
qm importdisk <vm_id> debian-12-generic-amd64.qcow2 local
# Attach the disk to the virtual machine
qm set <vm_id> -scsihw virtio-scsi-pci -virtio0 local:<vm_id>/vm-<vm_id>-disk-0.raw
# Add a serial output
qm set <vm_id> -serial0 socket
# Set the bootdisk to the imported Openstack disk
qm set <vm_id> -boot c -bootdisk virtio0
# Enable the Qemu agent
qm set <vm_id> -agent 1
# Allow hotplugging of network and disks
qm set <vm_id> -hotplug disk,network
# Add a single vCPU (for now)
qm set <vm_id> -vcpus 1
# Add a video output
qm set <vm_id> -vga qxl
# Set a second hard drive, using the inbuilt cloudinit drive
qm set <vm_id> -ide2 local:cloudinit
# Resize the primary boot disk (otherwise it will be around 2G by default)
# This step adds another 8G of disk space, but change this as you need to
qm resize <vm_id> virtio0 +8G
# Convert the VM to the template
qm template <vm_id>
```

See an short example below with real value :
```
qm create 9001 --name Debian12CloudInit --net0 rtl8139,bridge=vmbr0 --memory 2048
qm set 9001 --scsihw virtio-scsi-pci --scsi0 local:0,import-from=/var/lib/vz/template/iso/debian-12-generic-amd64.qcow2
qm resize 9001 scsi0 40G
qm set 9001 --serial0 socket --vga serial0
qm set 9001 --ide2 local:cloudinit
qm set 9001 --boot order=scsi0
qm set 9001 --agent enabled=1
qm template 9001
```


## Sources :

- [Ubuntu 24.04 VM Template for Proxmox and CloudInit](https://github.com/UntouchedWagons/Ubuntu-CloudInit-Docs?tab=readme-ov-file#making-a-ubuntu-2404-vm-template-for-proxmox-and-cloudinit)
- [cloud-init Debian 12 image on proxmox ](https://gist.github.com/tonyfairbanks/71e6705e206347ec9c916bb007bcc846)
- [tutoriel template de debian 12 sur proxmox](https://colinfo.fr/creation-dun-template-de-debian-12-sur-proxmox/)
- [Create a Debian Cloud-Init Template on Proxmox](https://ochoaprojects.github.io/posts/ProxMoxCloudInitImage/#create-a-proxmox-vm-using-the-image)
- []
