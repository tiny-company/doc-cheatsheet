# list file by extension

## To list file by extension :
```
find . -type f | sed -n 's/..*\.//p' | sort | uniq -c
```

This will show something like :
```
      1 avi
      1 docx
      1 iso
     10 jpg
     17 mkv
      2 mp4
     30 pdf
     71 png
      1 sh
     37 svg
      5 torrent
      1 txt
```

## to get filesize by extension :

- prerequisite : `gawk` package must be installed.
```
LC_ALL=C find . -name '?*.*' -type f -printf '%b.%f\0' |
  LC_ALL=C gawk -F . -v RS='\0' '
    {s[$NF] += $1; n[$NF]++}
    END {
      PROCINFO["sorted_in"] = "@val_num_asc"
      for (e in s) printf "%15d %4d %s\n", s[e]*512, n[e], e
    }' | numfmt --to=iec-i --suffix=B
```

This will show something like :
```
    78GiB 714695 jpg
    29GiB 68915 png
    1.2GiB 13965 jpeg
    131MiB 8025 ico
    30MiB 1398 com
```

## Sources :

- [find filesize by extension post](https://unix.stackexchange.com/questions/308846/how-to-find-total-filesize-grouped-by-extension)
- [tutorial to count file by extension](https://www.2daygeek.com/how-to-count-files-by-extension-in-linux/)