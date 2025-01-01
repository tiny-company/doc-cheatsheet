# rync with logs

To output rsync logs to a file :
```
rsync -av /source/ /dest/ --log-file=mylog.log
```

To filter data to show :
```
rsync -av /source/ /dest/ --log-file=mylog.log --info=COPY,DEL,NAME
```

- To show all FLAGS usable by `--info` option, use command `rsync --info=help` :
```
Use OPT or OPT1 for level 1 output, OPT2 for level 2, etc.; OPT0 silences.

BACKUP     Mention files backed up
COPY       Mention files copied locally on the receiving side
DEL        Mention deletions on the receiving side
FLIST      Mention file-list receiving/sending (levels 1-2)
MISC       Mention miscellaneous information (levels 1-2)
MOUNT      Mention mounts that were found or skipped
NAME       Mention 1) updated file/dir names, 2) unchanged names
NONREG     Mention skipped non-regular files (default 1, 0 disables)
PROGRESS   Mention 1) per-file progress or 2) total transfer progress
REMOVE     Mention files removed on the sending side
SKIP       Mention files skipped due to transfer overrides (levels 1-2)
STATS      Mention statistics at end of run (levels 1-3)
SYMSAFE    Mention symlinks that are unsafe

ALL        Set all --info options (e.g. all4)
NONE       Silence all --info options (same as all0)
HELP       Output this help message

Options added at each level of verbosity:
0) NONREG
1) COPY,DEL,FLIST,MISC,NAME,STATS,SYMSAFE
2) BACKUP,MISC2,MOUNT,NAME2,REMOVE,SKIP
```

To improve log verbosity :
```
rsync -av /source/ /dest/ --log-file=mylog.log --human-readable
```