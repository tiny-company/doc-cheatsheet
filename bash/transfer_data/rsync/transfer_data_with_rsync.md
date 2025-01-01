# Data transfer with rsync

## Description

How to transfer data from on host to another using rsync.

## Usage

### Default usage

```
rsync --progress -av -e "ssh" /archive/images/ username@[serverIP-or-domainname]:/archive/images --dry-run
```

Option explanation  :
- --dry-run is always useful to see what the action would have done, helps avoid nasty errors.
- -v adds output verbosity, which is useful to track where the operation is at
- --delete removes files that no longer exist on source from destination, which you generally want if you are creating a mirror of the data on the remote system. If your data is changing a lot, you might want to look into --delete-before, --delete-after, --delete-during to see which meets your needs best. I find --delete usually works fine however, but with TiB of data, that might matter. --delete-before is useful if you are dealing with an almost full remote disk, for example.

> BE CAREFUL WITH DELETE!! It will delete anything in the remote path not found in the local path, and that means, if you supply the wrong path, it will happily start deleting, or trying to delete, everything in that remote directory. Never use --delete without --dry-run the first time at least to make sure you have not made a mistake!

- -rtvz is a slightly faster way to sync files than -a. I find this one is good enough for most applications.

- -a basically creates almost a true mirror (-aHAX is mostly a full mirror) of the source.

- -a / --archive is same as -rlptgoD (no -H,-A,-X)

--progress shows progress as the job is running, which can be useful.

-e "ssh" is executing ssh, that could be a longer command if you need more ssh options in the command or whatever, like specific ssh port. Sample: -e "ssh -p 423"

-z : If you want to drop cpu usage, with not much change to bandwidth assuming binary files like images, then remove the -z compress option.

### If using OVH cloud storage

Use the options you want, see [previous part](#default-usage), and add them to the command below :
```
rsync -av archive.tar.gz pca@gateways.storage.gra.cloud.ovh.net:<the_repo_destination_on_OVH>/
```

## Sources :

- Stackexchange topic about rsync transfer file : https://unix.stackexchange.com/questions/670182/using-rsync-to-move-then-sync-lots-of-data-one-way
- Basic but very accessible tutorial about rsync usage : https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories
- A perfect tutorial that describe all the transfer data method : http://moo.nac.uci.edu/~hjm/HOWTO_move_data.html 
- Use Rsync twith the archive cloud platform of OVH : https://us.ovhcloud.com/public-cloud/cloud-archive/ 
- OVH tutorial to use SCP/SFTP on cold storage (cloud archive) : https://support.us.ovhcloud.com/hc/en-us/articles/5934950176019-How-to-Manage-Your-Archives-with-an-SFTP-SCP-Client