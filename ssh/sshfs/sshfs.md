# sshfs documentation

## Description

sshfs stand sshfilesystem, it permit to mount a folder (filesystem) from a distant source (remote server) using ssh.

## Usage

1. Create mount point

```shell
sudo mkdir /mnt/<folder name>
```

2. Mount the Remote File System Using SSHFS

```shell
sudo sshfs [-o <options>] <remote user>@<remote host>:/<path to remote directory> /mnt/<folder name>/
```

example with real data :
```shell
sudo sshfs -o allow_other,IdentityFile=/home/kb/.ssh/id_rsa ubuntu@131.153.142.254:/home/ubuntu/ /mnt/test/
```

The -o tag indicates the presence of added options:
- The allow_other option allows access to users other than root.
- The IdentityFile=<path to private key> option is for file systems with configured access via SSH. If the private key is under the root user, the command accepts a relative path. Otherwise, use the full link.



## Sources :

- [tutorial about sshf](https://phoenixnap.com/kb/sshfs)