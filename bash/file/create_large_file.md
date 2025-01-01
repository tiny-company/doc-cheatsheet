# create large file

Sometimes you need to create large file to test disk, location etc ...

Here is a simple example to create a file of 10Gb :
```
fallocate -l 10G gentoo_root.img
```

## Source :

- Tutorial to create large file : https://www.linuxshelltips.com/create-large-file-in-linux/
- turorial using fallocate : https://stackoverflow.com/questions/257844/quickly-create-a-large-file-on-a-linux-system