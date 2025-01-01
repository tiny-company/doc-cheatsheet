# copy file and exclude some with rsync

There is no "--exclude" option with the cp command, a hack is to copy folder and exclude some file in it by doing a rsync :
```
rsync -r --exclude={folder1,folder2} source_folder destination 
```

- for just one file : 
```
rsync -r --exclude '.git' source target
```