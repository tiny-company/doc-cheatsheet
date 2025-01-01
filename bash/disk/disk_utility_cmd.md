# disk utility commands

**Reminder that any change to the disk or partition is a dangerous action and must me done under backup or snapshot cover !**

## How to resize linux disk partition

- [Tutorial to resize ext3 partition](https://www.howtoforge.com/linux_resizing_ext3_partitions)
- [Extend a partition with parted tools](https://rdr-it.com/troubleshooting/linux-etendre-partition/)
- [Resize a filesystem and partition on linux](https://www.thegeekdiary.com/how-to-resize-extend-a-partition-based-file-system-in-linux/)
- [OVH tutorial to extend a linux partition](https://docs.ovh.com/fr/public-cloud/augmenter-la-taille-dun-disque-supplementaire/##etendre-la-partition-instance-linux)

## Managing linux disk and partition

- [Tutorial to manage disk and parition on linux](https://www.malekal.com/fdisk-gfdisk-creer-supprimer-redimensionner-des-partitions-de-disque-en-ligne-de-commandes-linux/)

> Note that you cannot manipulate the main disk as it cannot be unmount, only additional disk can !

## Move directory/path to another partition

- [Tutorial to move /home directory to a new partition](https://www.tecmint.com/move-home-directory-to-new-partition-disk-in-linux/)

## /etc/fstab

This file contain all the disk that will be mounted at system start (use the UUID (block id) to to select the disk)

## blkid

This command get the UUI (disk block id), exmaple :
```
admin@server-1:~$ sudo blkid

/dev/vda1: UUID="51ba13e7-398b-45f3-b5f3-fdfbe556f62c" TYPE="ext4" PARTUUID="000132ff-01"
/dev/vdb1: UUID="2e4a9012-bf0e-41ef-bf9a-fbf350803ac5" TYPE="ext4" PARTUUID="95c4adcc-01"
```

## lsblk :

cmd that list the block devices

example (on WSL):
```
lsblk
NAME MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda    8:0    0 363.1M  1 disk
sdb    8:16   0     2G  0 disk [SWAP]
sdc    8:32   0     1T  0 disk /mnt/wslg/distro
```

## fdisk :

cmd that help managing disk and partition, [this site has a goood tutorial](https://www.malekal.com/fdisk-gfdisk-creer-supprimer-redimensionner-des-partitions-de-disque-en-ligne-de-commandes-linux/)

- to install it : `sudo apt install fdisk`

- list disk and their partition : `fdisk -l`

- list partition of a specific disk : `fdisk -l /dev/sda`

- To use fdisk utility on a disk : `fdisk <disk>`

<br>

| Lettre	| Description| 
| ----------- | ----------- |
| d |  	supprimer la partition | 
| F | 	afficher l’espace libre non partitionné | 
| l | 	afficher les types de partitions connues | 
| n | 	ajouter une nouvelle partition | 
| p | 	afficher la table de partitions | 
| t | 	modifier le type d’une partition | 
| v | 	vérifier la table de partitions | 
| i | 	Afficher des renseignements sur la partition | 
| w | 	écrire la table sur le disque et quitter | 
| q | 	quitter sans enregistrer les modifications |