# last reboot infos 

## know when the system has reboot

- With `last` or `last reboot` (same result): 

``` 
 last

wtmp begins Fri Dec  9 14:58:29 2022
``` 

- With `uptime`
```
uptime -s
2022-08-29 08:43:19
```

- With `who` :
```
who -b
System reboot time: Sun Jun 16 05:12:39 2022
```

- With `Procinfo` (must install package "procinfo")




## Source : 

- 5 command to know when a system has reboot : https://www.howtouselinux.com/post/check-last-reboot-time-in-linux
- How To Find Linux Reboot Reasons? : https://kuberty.io/blog/how-to-find-linux-reboot-reasons/
- who and what reboot my system tutorial : https://web.archive.org/web/20170904210829/http://scofaq.aplawrence.com:80/FAQ_scotec1haltcatch.html