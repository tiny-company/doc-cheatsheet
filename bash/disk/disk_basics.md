# disk basics 

## Description

This cheatsheet describes how works disk storage on linux :
- [The Disk](#the-disk)
- [The Partition](#the-partition)
- [The Filesystem](#the-file-system)

## The Disk

This is the physical storage (HDD, SD card, USB key, CD-ROM, ...) where data are stored.

### Device file

Because on linux, everything is treated like a file, device / disks are also represented as [Device File](https://en.wikipedia.org/wiki/Device_file). These special files allow an application program to interact with a device by using its device driver via standard input/output system calls (SYSCALL).

### The dev directory

Most device files are managed as part of a virtual file system traditionally mounted at **[/dev](https://www.baeldung.com/linux/dev-directory)**. The /dev/ directory consists of files that represent devices that are attached to the local system. 

### dev/sdx files

A more detailed and direct way we can identify device files in the /dev directory is by using the device’s major and minor numbers. For example, disk devices have a major number of 8 (see [lsblk commands below to see the device major number](#linux-commands)), which assigns them as SCSI block devices. Note that the SCSI subsystem manages all PATA (Parallel Advanced Technology Attachment) and SATA (Serial Advanced Technology Attachment) hard drives. This is because the old ATA subsystem is not maintainable due to the poor quality of its code. As a result, hard drives that would previously be designated as hd[a-z] are now referred to as sd[a-z]. Currently, sd[a-z] is the most used way to refer to hard disks. Though, some distros still use hd[a-z].

SCSI is a microprocessor-controlled smart bus. It allows us to add up to 15 peripheral devices to the computer. These devices include hard drives, scanners, USB, printers, and many other devices. It stands for small computer system interface.

**/dev/sd[a-z] stands for the hard drive**. During installation, Linux takes the first hard disk found and assigns it the value sda. It does the naming in an alphabetical order depending on the number of disks found. If we have multiple partitions in the hard disk, the system consecutively appended a number starting from sda1 to sda15. In a single hard disk, we can only have a maximum of 15 partitions.

To resume : 
- all reference to sd[a-z] correspond to a disk (i.e : sda, sdb) 
- all reference to sd[a-z][1-15] correspond to a partition (i.e : sda1, sda2) 

### Linux commands

On linux 2 commands can be used to list the disks : 

- `lsblk` : This command shows us all the available block devices connected to the system, except RAM. It displays the output in a tree-like structure. (Type : disk or partition and mountpoint : where disk is mounted on linux filesystem hierarchy). Find an example of this command output below : 
```
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda               8:0    0   50G  0 disk
└─sda1            8:1    0   50G  0 part /
sdb               8:16   0  200G  0 disk
└─vg--data-data 254:0    0  200G  0 lvm  /data
```

- `fdisk -l` : This command shows us the capacity of our hard disk, the partitions within it, and their respective sizes. Find an example of this command output below : 
```
Disk /dev/sda: 50 GiB, 53687091200 bytes, 104857600 sectors
Disk model: QEMU HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x3414873f

Device     Boot Start       End   Sectors Size Id Type
/dev/sda1  *     2048 104857566 104855519  50G 83 Linux


Disk /dev/sdb: 200 GiB, 214748364800 bytes, 419430400 sectors
Disk model: QEMU HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/mapper/vg--data-data: 200 GiB, 214744170496 bytes, 419422208 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```

## The Partition

Because disks store lot of data, it is important to access it quickly. Partition are disk's zone where similar data are stored. In example, partition for user data, partition for operative system data, partition for temporary data ...

To resume : 
- all reference to sd[a-z] correspond to a disk (i.e : sda, sdb) 
- all reference to sd[a-z][1-15] correspond to a partition (i.e : sda1, sda2) 

### Partition Table

Each disk has a partition table located at the start of each. This table contains all data relative to each partition of the disk (like an index for all the partition on the disk). There is 2 major standards for partition table on disks :
- [MBR (Master boot Record)](https://fr.wikipedia.org/wiki/Master_boot_record)
- [GPT (GUID PArtition Table)](https://fr.wikipedia.org/wiki/GUID_Partition_Table)

### Partition Type (for MBR only)

On a disk which partition table is MBR type, we can find 3 partitions types :

- Primary partition : Because a disk with MBR partition table can only have 4 partitions, primary partition are those which description is stored under the MBR of a disk.This partition type must be formated (contain a file system)

![mbr partition](https://doc.ubuntu-fr.org/_media/doc/disque_dur_partitions_primaires.png?w=300&tok=432522)

- Extended partition : Because of this limit, when administrator needs more than 4 partitions, they can split one partition (one and only one). This splitted partition is called "extented partition" and can contain more partition. Best practice recommand to put the extended partition at the end (to be the last partition). This partition type must not be formated (should not contain a filesystem as data will not directly be written on).

- Secondary partition : also named "logical partition" are the partition which are created under an extended partition. This partition type must be formated (contain a file system)

## The File System

Inside the partition, a filesystem need to be created. It is use to organize data inside the partition.The filesystem help to locate at what place is located the desired data, it act like an index like for books.


## Sources : 

- [Stack overflow post about how disk works](https://stackoverflow.com/questions/24429949/device-vs-partition-vs-file-system-vs-volume-how-do-these-concepts-relate-to-ea)
- [Dell documentation about disks](https://www.dell.com/support/kbdoc/fr-fr/000131456/types-et-definitions-des-partitions-et-repertoires-linux-ubuntu)
- [Ubuntu wiki about disk and partition](https://doc.ubuntu-fr.org/partitions)