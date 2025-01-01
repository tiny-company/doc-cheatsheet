# transfer file with scp

## command explain :
```
scp [other options] [source username@IP]:/[directory and file name] [destination username@IP]:/[destination directory]
```
Here’s a breakdown of the command:

    [other options] ‒ modifiers you can add to the SCP command. We’ll cover the most popular ones later.
    [source username@IP] ‒ username and IP of the machine that hosts the target file.
    :/ ‒ informs the SCP command that the user will type in the source directory.
    [directory and file name] ‒ the file’s location and name.
    [destination username@IP] ‒ username and IP of the destination system.
    [destination directory] ‒ the destination directory where the file will be saved.

## examples

- transfert file from server to local :
```
scp root@191.162.0.2:/writing/article /users/Hostinger/desktop/article
```

- transfert file from a server to another server :
```
scp root@191.162.0.2:/writing/article scp root@191.162.0.1:/writing/article
```

## Option

- specify another port :
```
scp -P 2322 <source> <destination>
```

- copy a directory :
```
scp -r <source> <destination>
```

- 3 way transfer (source > local machine > destination) :
```
scp -3 root@191.162.0.2:/writing/article/scp.zip hostinger@11.10.0.1:/publishing
```
