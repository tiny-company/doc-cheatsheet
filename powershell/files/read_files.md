# read_files powershell

- Read a file :
```
Get-Content -Path ./file_to_read
```

- To apply text filter (grep equivalent) :
```
Get-Content -Path ./file_to_read | Select-String -Pattern "foobar"
```

- To read file with new data (equivalent of `tail -f`) :
```
Get-Content -Path "C:\scripts\test.txt" -Wait
```

## Sources :

- [Official powershell documentation about get-content](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content?view=powershell-7.4)
- [StackOverflow tail equivalent in powershell](https://stackoverflow.com/questions/4426442/unix-tail-equivalent-command-in-windows-powershell)