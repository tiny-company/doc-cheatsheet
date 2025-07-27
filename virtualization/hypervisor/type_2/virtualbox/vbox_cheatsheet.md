# virtualbox cheatsheet

- list virtual machine :
```shell
VBoxManage list vms
```

- export virtual machine to ova format :
```shell
VBoxManage export your_virtual_machine_name -o your_virtual_machine.ova --ovf10
```

- convert image to ovf to qcow2 :
```shell
# extract ova and convert vmdk file to qcow2
tar -xvf your_virtual_machine.ova
qemu-img convert -f vmdk -O qcow2 your_virtual_machine-disk001.vmdk destination_image.qcow2
sudo mv destination_image.qcow2 /var/lib/libvirt/images/
```

