# See and edit file attributes

- list file attributes :
```
lsattr <file>
```

with attribute Value :
The  letters 'aAcCdDeijPsStTu' select the new attributes for the files:
append only (a), no atime updates (A), compressed (c), no copy on write
(C), no dump (d), synchronous directory updates (D), extent format (e),
immutable (i), data journalling  (j),  project  hierarchy  (P),  secure
deletion  (s),  synchronous  updates  (S),  no tail-merging (t), top of
directory hierarchy (T), and undeletable (u).

The following attributes are read-only, and may be listed by  lsattr(1)
but  not  modified by chattr: encrypted (E), indexed directory (I), and
inline data (N).

- add file attributes :
```
chattr +<attribute_letter> <file>
```

- remove file attributes :
```
chattr -<attribute_letter> <file>
```