# DNS powershell command

## Resolve DNS name (nslookup equivalent)
Resolve-DnsName

## List DNS servers 
```
Get-DnsClientServerAddress
```

## Clear dns cache
```
Clear-DnsServerCache
```

- [Windows doc for this 'clear dns cache'](https://learn.microsoft.com/en-us/powershell/module/dnsserver/clear-dnsservercache?view=windowsserver2022-ps)

## Configure a DNS server address using PowerShell 
```
Set-DnsClientServerAddress
```