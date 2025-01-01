# Data compression using tar

## Description

Use compression with tar in order to reduce the size of a file/folder

## Usage

### Compress

```
tar [flags] destinationFileName sourceFileName
```

With flags :
- c :	Create a new archive. 	We use this flag whenever we need to create a new archive.
- z :	Use gzip compression. 	When we specify this flag, it means that archive will be created using gzip compression.
- v :	Provide verbose output. 	Providing the -v flag shows details of the files compressed.
- f :	Archive file name. 	Archive file names are mapped using the -f flag.
- x :	Extract from a compressed file. 	We use this flag when files need to be extracted from an archive.

### Change path to source File

By default tar will compress all the path to the sourcefile name, example :
If using `tar [flags] example.tar.gz /opt/webdrone/folderToTar`, then the example.tar.gz will contain the path to "folderToTar", meaning that when decompressing (opening the archive), it will create "/opt/webdrone/folderToTar" at then current path.

To avoid this, use the  `-C` option that "change" directory to defined path :
```
tar -czvf my_directory.tar.gz -C my_directory .
```

See [this stackoverflow question for more](https://stackoverflow.com/questions/939982/how-do-i-tar-a-directory-of-files-and-folders-without-including-the-directory-it)

### How to remove files after compression

**don't misunderstand : this delete the *original file* while creating the archive**

Let's say we don't want to keep the original files after creating an archive. For that, we can use the --remove-files flag.

```
tar -czvf logs_archive.tar.gz * --remove-files
```

### How to view the contents of an archive

You might need to view the contents of an archive without actually extracting it. You can do this with the -t flag.

```
tar -tvf logs_archive.tar.gz
```

### How to extract an archive

To extract files from an archive, you use the -x flag like this:

```
tar -xzvf logs_archive.tar.gz
```

Flags explanation :
- x : is extracting and archive.
- z : specifies that the archive is gzip.
- v : is providing details of the files that have been archived.
- f : is extracting from the archive named 'logs_archive.tar.g

### Tips : running in background

Here's a useful tip: commands that take a long time to execute can continue in the background with &.

Adding files to an archive and extracting an archive can take a while. To keep the commands running in the background while you keep working, pair the command with & like this:
```
tar -xzvf logs_archive.tar.gz &
```


## Sources :

- tutorial tar usage : https://www.freecodecamp.org/news/how-to-compress-files-in-linux-with-tar-command/