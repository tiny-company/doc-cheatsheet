# instance using bootscript migration

## Context

Since 08/2023, scaleway cannot support anymore the bootscript feature. Instance using it get unreachable every wednesday. To prevent this Infra team need to migrate the instance.

## Preprod migration

- instance type : X64-60GB
- localization : AMS1
- original public ip : 51.15.79.217

### Step 1 : identify UEFI support

- check UEFI support :
```
ls -ld /sys/firmware/efi
```

command output show "ls: cannot access /sys/firmware/efi: No such file or directory" meaning the UEFI directories are not present on your Instance.


### Step 2 : migration using "Option 1 Create a unified snapshot of the volume(s) and rebuild block volume(s) from the snapshot"

- [Create a snapshot of the volume using the unified snapshot type](https://www.scaleway.com/en/docs/compute/instances/how-to/create-a-snapshot/)

- [Create a new block volume from the previous unified snapshot](https://www.scaleway.com/en/docs/storage/block/how-to/create-a-volume/) :
    - under snapshot tab, select the snapshot and convert it into a volume.

- [Create and start a new Instance using its own boot volume in local boot mode. Make sure the Instance is in the same zone as the volume](https://www.scaleway.com/en/docs/compute/instances/how-to/create-an-instance/)
    - using the cli to create instance :
    ```
    scw init
    scw instance server create name=preprod_new project-id=6a0c2ca8-917a-418a-90a3-05949b55a7ae zone=nl-ams-1 type=GP1-M image=ubuntu_jammy ip=new root-volume=l:100GB
    ```
    - show instance on specific zone (confirm instance creation) :
    ```
    scw instance server list zone=nl-ams-1
    ```

- [Attach the block volume to the new Instance](https://www.scaleway.com/en/docs/storage/block/how-to/attach-a-volume/) :
    - attach the volume which was previously converted from snapshot to the instance

- [Once logged into the Instance, mount the partition available in the block volume and access your data](https://www.scaleway.com/en/docs/storage/block/how-to/mount-and-use-volume/) :
    - show block volume available :
    ```
    lsblk
    ```
    - format the block volume (change according do device "sdx" - default is sda) :
    ```
    mkfs.ext4 /dev/sda
    ```
    - check volume format (ext4) :
    ```
    lsblk -f
    ```

- edit fstab to boot on the new block volume (for permanent mount) :
```
echo "/dev/lg_data/data /data ext4 defaults 0 0" >> /etc/fstab
```

- copy file using rsync :
```
rsync -a /mnt/old_preprod/opt /
```


## Source :

- [scaleway tutorial for bootscript instance migration](https://www.scaleway.com/en/docs/compute/instances/troubleshooting/bootscript-eol/)
- [boot mode on scaleway](https://www.scaleway.com/en/docs/compute/instances/how-to/use-boot-modes/)

- [create an instance image (full backup) on scw](https://www.scaleway.com/en/docs/compute/instances/how-to/create-a-backup/)

- [create a volume snapshot (backup) on scw](https://www.scaleway.com/en/docs/compute/instances/how-to/create-a-snapshot/)

- [scw marketplace cli](https://github.com/scaleway/scaleway-cli/blob/master/docs/commands/marketplace.md)

- [solution to avoid creating an new instance](https://lowendtalk.com/discussion/186735/scaleway-vc1-x-x64-x-start1-x-bootscript-to-local-boot-in-place-migration-on-the-same-instance)