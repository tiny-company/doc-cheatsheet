# create container template

- Update pve template source (get latest template from proxmox) :
```
pveam update
```

- List available templates :
```
pveam available
```

- download image (container template) into proxmox local image storage :
```
pveam download <images storage> <container template name>
```

- list local images :
```
 pveam list <images storage>
```


