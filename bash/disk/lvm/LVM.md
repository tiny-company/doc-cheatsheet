# LVM (logical Volume Management)

Find here command and guide about LVM.

## Physical Volume (pv)

```
pvdisplay
```

- [More on Physical Volume display ](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/logical_volume_manager_administration/physvol_display)

## Volume Group (vg)

### Show existing volume group 

```
vgdisplay
```

- [More on volume]

### Create a Volume Group

To create a volume group from one or more physical volumes, use the vgcreate command. The vgcreate command creates a new volume group by name and adds at least one physical volume to it.
The following command creates a volume group named vg1 that contains physical volumes /dev/sdd1 and /dev/sde1 :
```
vgcreate vg1 /dev/sdd1 /dev/sde1
```

### Extend existing volume group

To add additional physical volumes to an existing volume group, use the vgextend command. The vgextend command increases a volume group's capacity by adding one or more free physical volumes.
The following command adds the physical volume /dev/sdf1 to the volume group vg1.
```
vgextend vg1 /dev/sdf1
```

### Removing Physical Volumes from a Volume Group

To remove unused physical volumes from a volume group, use the vgreduce command. The vgreduce command shrinks a volume group's capacity by removing one or more empty physical volumes. This frees those physical volumes to be used in different volume groups or to be removed from the system.

Before removing a physical volume from a volume group, you can make sure that the physical volume is not used by any logical volumes by using the pvdisplay command. 
```
vgdisplay /dev/sdx
```

If the physical volume is still being used you will have to migrate the data to another physical volume using the pvmove command. Then use the vgreduce command to remove the physical volume.

The following command removes the physical volume /dev/hda1 from the volume group my_volume_group.
```
vgreduce my_volume_group /dev/sdx
```

- [More on removing physical volume from a volum group](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/logical_volume_manager_administration/vg_remove_pv)


## Logical Volume (lv)

### Show logical Volume 

- easy to understand output :
```
lvs
```

- More infos on logical volume :
```
lvdisplay
```

### Extend existing logical volume

- first create a Physical Volume : 
```
pvcreate /dev/sdX
```
When you attach the new storage /dev/sdX, you need to use the pvcreate command in order for the disk to be initialized and be seen by the Logical Volume Manager (LVM).

- Extend the Volume Group : 
```
vgextend my_volume_group /dev/sdx
```

- Extend the Logical Volume :
```
lvextend -l +100%FREE /dev/my_volume_group/my_logical_volume
```

- [Extend the filesystem](https://access.redhat.com/articles/1196353) under the logical volume : 
```
resize2fs /dev/my_volume_group/my_logical_volume
```

- [More at resizing logical volume](https://www.redhat.com/sysadmin/resize-lvm-simple)

## Sources : 

- [Ubuntu guide to LVM, more theorical](https://doc.ubuntu-fr.org/lvm)
- [Redhat guide to LVM, with usefull command](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/logical_volume_manager_administration/vg_admin#VG_create)
- [complete guide to understand the LVM](https://linuxhandbook.com/lvm-guide/)
- [For info ,ansible guide to automatize this](https://www.redhat.com/sysadmin/automating-logical-volume-manager)