# proxmox qemu template

## Description

How to generate proxmox quemu virtual machine template.

## Prerequisites

- download proxmox templates :
```
pveam download local debian-10.0-standard_10.0-1_amd64.tar.gz
```

## Usage 

To run on proxmox server :

- Generate qemu ubuntu template :
```
cd /var/lib/vz/template/iso
wget https://cloud-images.ubuntu.com/releases/20.04/release/ubuntu-20.04-server-cloudimg-amd64.img
sudo virt-customize -a ubuntu-20.04-server-cloudimg-amd64.img --install qemu-guest-agent
sudo virt-customize -a ubuntu-20.04-server-cloudimg-amd64.img --root-password password:stephane
sudo qm create 9999 --name "ubuntu.robert.local" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
sudo sudo qm importdisk 9999 ubuntu-20.04-server-cloudimg-amd64.img local
qm set 9999 --tags "template,test"
sudo qm set 9999 --scsihw virtio-scsi-pci --scsi0 local:9999/vm-9999-disk-0.raw
sudo qm set 9999 --boot c --bootdisk scsi0
sudo qm set 9999 --ide2 local:cloudinit
sudo qm set 9999 --serial0 socket --vga serial0
sudo qm set 9999 --agent enabled=1
sudo qm set 9999 --ipconfig0 ip=dhcp
sudo qm template 9999
```

- Generate lxc debian 12 template :
```
cd /var/lib/vz/template/iso

pct create <VMID> /var/lib/vz/template/cache/debian-12-standard_12.x-1_amd64.tar.gz \
    --hostname debian12-template \
    --storage local-lvm \
    --rootfs local-lvm:8 \
    --net0 name=eth0,bridge=vmbr0,ip=dhcp \
    --console 1 \
    --cpulimit 1 \
    --memory 2048

pct stop <VMID>
pct template <VMID>
```

## Sources :

- [pct man](https://pve.proxmox.com/pve-docs/pct.1.html)