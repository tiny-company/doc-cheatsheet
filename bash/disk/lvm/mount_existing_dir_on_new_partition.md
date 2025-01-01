# mount existing dir on new partition

This guide is usefull for example when the main partition is full and a specific dir take all space (/var).

## Without LMV 

### 1.Create file system 

Create the file system partition on the new disk using [mkfs](https://www.malekal.com/mkfs-formater-et-creer-un-systeme-de-fichiers-ext4-ntfs-fat-sur-linux/).
Example with ext4 : 
```
mkfs -t ext4 /dev/sdx1
```

### 2.Mount the new partition

- create mountpoint :
``` 
mkdir /var2
```

- mount the new partition at the mountpoint :
```
mount /dev/sdx1 /var2
```

### 3.Copy current dir

Sync existing directory (/var):
```
rsync -a /var/ /var2
```

### 4.Add entry to /etc/fstab

- edit [fstab](https://www.linuxtricks.fr/wiki/fstab-explications-sur-le-fichier-et-sa-structure) : 
```
echo "/dev/sdx1    /var    ext4    defaults      2 2" | cat /etc/fstab -
```

### 5.Reboot to apply

## With LMV

### 1.Create a new /var filesystem with LVM

- Create a new 60GB logical volume in the `VolGroup00` group called `var` : 
```
sudo lvcreate -L 60GB -n var VolGroup00
```

- Create an ext4 filesystem on this new `var` volume (lvm) : 
```
sudo mkfs.ext4 /dev/VolGroup00/var
```

- Mount this filesystem at a temporary mount-point :
```
sudo mkdir /var.new
sudo mount /dev/VolGroup00/var /var.new
```

- The files can be copied with rsync, with its -a, --archive option to preserve time-stamps, ownership, modes, etc. and its -X, --xattrs option to preserve the extended attributes such as the security labels used by AppArmor and SELinux:
```
sudo rsync -raX /var/ /var.new/
```

### 2.Update the filesystem table

- edit [fstab](https://www.linuxtricks.fr/wiki/fstab-explications-sur-le-fichier-et-sa-structure) : 
```
echo "/dev/mapper/VolGroup00-var    /var    ext4  defaults  0 0" | cat /etc/fstab -
```

### 3.Reboot to apply

### 4.Remove temporary mount-point

- After the machine has restarted, the new filesystem will be mounted on /var so the temporary mount-point can be safely removed:
```
sudo rmdir /var.new
```

### 5. Recover disk space from the root filesystem

- The old /var files will still be taking up space on the root partition but they are not easily accessible while another filesystem is mounted at /var (they are “masked” by the new filesystem using the /var directory as its mount-point). Use a temporary mount-point to mount the root filesystem so that contents of the original /var directory are available by an alternative path.
```
sudo mkdir /old-root
sudo mount /dev/mapper/VolGroup00-root /old-root/
sudo rm -rf /old-root/var/*
sudo umount /old-root/
sudo rmdir /old-root/
```

## Sources : 

- [How can I store /var on a separate partition](https://askubuntu.com/questions/39536/how-can-i-store-var-on-a-separate-partition)
- [How to move /var directory to another partition](https://linuxconfig.org/how-to-move-var-directory-to-another-partition)