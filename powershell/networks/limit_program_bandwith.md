# Limit program bandwith 

- Limit program bandwith using GPO (example with ftp server below) :
```
New-NetQosPolicy -Name "FTP" -AppPathNameMatchCondition "ftp.exe" -ThrottleRateActionBitsPerSecond 1MB
```
> Note : this GPO will only work for outbound traffic

## Source : 

- [stack exchange topic about bandwith limitation on windows](https://superuser.com/questions/135719/way-to-limit-bandwidth-of-programs-on-windows)

