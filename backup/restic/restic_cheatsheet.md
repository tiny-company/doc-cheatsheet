# restic cheatsheet

- list backup snapshot :
```
restic -r <restic_repository> snapshots
```

example:
```
restic -r s3:https://s3.fr-par.scw.cloud/wd-backup-cicd-test snapshots
```

- list files in a snapshot :
```
restic -r <restic_repository> ls <snapshot_ID> ls
```

example :
```
restic -r s3:https://s3.fr-par.scw.cloud/wd-backup-cicd-test ls latest
```