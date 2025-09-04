# proxmox qemu template

## Description

How to generate proxmox quemu virtual machine template.

## Prerequisites

- download proxmox templates :
```shell
pveam download local debian-10.0-standard_10.0-1_amd64.tar.gz
```

## Usage

To run on proxmox server :

- Generate qemu ubuntu template :
```shell
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
```shell
CONT_ID=151
pveam download local debian-12-standard_12.7-1_amd64.tar.zst
cd /var/lib/vz/template/iso

pct create ${CONT_ID} /var/lib/vz/template/cache/debian-12-standard_12.7-1_amd64.tar.zst \
    --hostname debian12-template \
    --storage local-lvm \
    --rootfs local-lvm:8 \
    --net0 name=eth0,bridge=vmbr0,ip=dhcp \
    --console 1 \
    --cpulimit 1 \
    --memory 2048

pct stop ${CONT_ID}
pct template ${CONT_ID}
```

### script

- run code below in order the create the script that will generate a new container template using init cloud
```shell
apt update -y && apt install libguestfs-tools -y
cat << 'EOF' > create_container.sh
set -eof
## default values
CLOUD_INIT_FILE="/var/lib/vz/template/iso/ubuntu-20.04-server-cloudimg-amd64.img"
CLOUD_INIT_URL="https://cloud-images.ubuntu.com/releases/20.04/release/ubuntu-20.04-server-cloudimg-amd64.img"
## mandatory values
CONT_ID=2000
CONT_NAME="ubuntu.test.local"
CONT_TAGS="template,test"
CONT_MEMORY=2048
CONT_CORES=2
CONT_NET=virtio,bridge=vmbr0
## container template creation
cd /var/lib/vz/template/iso
if ! [ -f ${CLOUD_INIT_FILE} ]; then
    wget ${CLOUD_INIT_URL}
fi
virt-customize -a ${CLOUD_INIT_FILE} --install qemu-guest-agent --run-command 'systemctl enable qemu-guest-agent.service'
virt-customize -a ${CLOUD_INIT_FILE} --install qemu-guest-agent --run-command 'apt install whois'
virt-customize -a ${CLOUD_INIT_FILE} --root-password password:root
qm create ${CONT_ID} --name "${CONT_NAME}" --memory ${CONT_MEMORY} --cores ${CONT_CORES} --net0 ${CONT_NET}
qm importdisk ${CONT_ID} ${CLOUD_INIT_FILE} local
qm set ${CONT_ID} --scsihw virtio-scsi-pci --scsi0 local:${CONT_ID}/vm-${CONT_ID}-disk-0.raw
qm set ${CONT_ID} --boot c --bootdisk scsi0
qm set ${CONT_ID} --ide2 local:cloudinit
qm set ${CONT_ID} --serial0 socket --vga serial0
qm set ${CONT_ID} --agent enabled=1
qm set ${CONT_ID} --ipconfig0 ip=dhcp
qm set ${CONT_ID} --tags ${CONT_TAGS}
qm template ${CONT_ID}
EOF
chmod +x create_container.sh
```

- after editing `create_container.sh` run it :
```shell
./create_container.sh
```

- To create a virtual machine from this template :
```shell
CONT_TEMPLATE_ID=2000
CONT_ID=151
CONT_IP_ADDR="192.168.139.32/24"
CONT_IP_GW="192.168.139.1"
qm clone ${CONT_TEMPLATE_ID} ${CONT_ID} --name test-cloud-init
qm set ${CONT_ID} --ipconfig0 ip=${CONT_IP_ADDR},gw=${CONT_IP_GW}
```

## Sources :

- [pct man](https://pve.proxmox.com/pve-docs/pct.1.html)