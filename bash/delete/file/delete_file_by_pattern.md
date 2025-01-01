# delete file by pattern

- Delete all file ending with a specific extension :
```
find . -type f -name '*.txt' -delete
```

- Delete all file NOT ending with a specific extension :
```
find . -type f ! -name '*.txt' -delete
```

- Delete file that correspond to a specific pattern (using -delete option from find):
```
find . -type f -name '[0-9][0-9].*' -delete
```

- Delete file that correspond to a specific pattern (using rm ):
```
find . -type f -name '[0-9][0-9].*' -exec rm {} \;
```

- Delete file by date :
```
find -maxdepth 1 -type f -newermt "Nov 22" \! -newermt "Nov 23" -delete
```

with :
- maxdepth 1 (must be specified before other criteria) limits the search to the specified directory (i.e. it doesn't recurse).
- newermt stands for "newer modified time," and the date is provided in a human-readable format.
- "\!" negates the following condition. So, this part means "files that were not modified after Nov 23." In effect, it combines with the previous condition to find files modified between Nov 22 and Nov 23
- delete: Once the files matching the conditions are found, this option deletes them.

## Source :

- [delete file ending with .txt](https://unix.stackexchange.com/questions/78376/in-linux-how-to-delete-all-files-except-the-pattern-txt)
- [delete file by pattern](https://unix.stackexchange.com/questions/174092/delete-files-having-a-certain-pattern-in-their-names)
- [delete file by specific date stackoverflow](https://stackoverflow.com/questions/4254618/delete-file-specific-date)