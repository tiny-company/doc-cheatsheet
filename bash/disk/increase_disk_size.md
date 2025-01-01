# increase disk size

To increase the size disk :

- first umount :
```
sudo umount <disk mount path>
```

<disk mount path> is often "/dev/sdb"

- You can use the command `fdisk -l` to list the disk and their partition to find the dev disk path.

- then recreate the partition :
```
sudo fdisk <dev disk path>
```
<disk mount path> is often "/dev/sdb"  (as it is the second disk added after the sda1)

- Choose "d" for deleting the disk partition
- It will ask the partition id to delete : choose 1 as it has only 1 parition on this disk
- Choose "n" option to create a new partition then :
    - select the primary partition
    - choose default partition number
    - choose the first sector (choose the default one : 2048)
    - choose the last sector (choose the default one unless you know what you do)

- choose the "w" option : to write your changes

- check the partition :
```
sudo e2fsck -f <dev disk path>
```

- Finally resize the disk :
```
sudo resize2fs <dev disk path>
```

- mount again the disk :
```
sudo mount <dev disk path> </mnt/disk/>
```

## Sources :

- [Augmenter la taille d’un disque supplémentaire](https://help.ovhcloud.com/csm/fr-public-cloud-compute-storage-increase-additional-disk-size?id=kb_article_view&sysparm_article=KB0050831)