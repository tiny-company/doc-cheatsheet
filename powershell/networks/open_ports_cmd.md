# Open ports powershell 

## See what port are open on the local machine 

### TCP ports

- show TCP ports listening by the local machine
```
get-nettcpconnection | where {($_.State -eq "Listen") -and ($_.RemoteAddress -eq "0.0.0.0")}
```

- Same command as above with more fields :
```
get-nettcpconnection | where {($_.State -eq "Listen") -and ($_.RemoteAddress -eq "0.0.0.0")} | select LocalAddress,LocalPort,RemoteAddress,RemotePort,State,@{Name="Process";Expression={(Get-Process -Id $_.OwningProcess).ProcessName}} | ft
``` 


### UDP ports

- Same command as above but for UDP ports :
```
Get-NetUDPEndpoint | Where {$_.LocalAddress -eq "0.0.0.0"} | select LocalAddress,LocalPort,@{Name="Process";Expression={(Get-Process -Id $_.OwningProcess).ProcessName}}
```