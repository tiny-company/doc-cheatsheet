# convert virtualbox machine to qemu image

- convert vmdk to qcow2 format :
```shell
qemu-img convert -f vmdk -O qcow2 [source_file].vmdk [destination_file].qcow2
```

- create a new virtual machine os qemu :
```shell
sudo virt-install --name=new_name --disk path=/var/lib/libvirt/images/destination_image.qcow2,form
at=qcow2 --import --osinfo detect=on --memory 4096
```
