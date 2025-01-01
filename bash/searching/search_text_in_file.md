# search text in file 

```
grep -rnw '/path/to/somewhere/' -e 'pattern'
```

- r or -R is recursive,
- n is line number
- w stands for match the whole word.
- l (lower-case L) can be added to just give the file name of matching files.
- e is the pattern used during the search

example : 
```
grep -rnw . -e 'firewall'
```

## Source :

- [article about searching text in multiple file from stackoverflow](https://stackoverflow.com/questions/16956810/how-to-find-all-files-containing-specific-text-string-on-linux)