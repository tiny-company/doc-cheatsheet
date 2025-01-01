# Active session 

## Show session

- to show active session with "w" :
```
w
``` 

result example :
```
 15:30:32 up 166 days, 13:46,  3 users,  load average: 10.51, 10.13, 7.30
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
root     pts/0    51.15.223.6      14:11   22:51   0.09s  0.09s -bash
root     pts/1    51.15.223.6      15:29    0.00s  0.06s  0.02s w
```

TTY gives you information about the terminal used to log on. pts means pseudo terminal slave which indicates that the user logged in via SSH connection.

- to show active session with "who" :

```
root     pts/0        2023-10-10 14:11 (51.15.223.6)
root     pts/1        2023-10-10 15:29 (51.15.223.6)
``` 

show more infos using "who -a"

result example :
```
 15:30:32 up 166 days, 13:46,  3 users,  load average: 10.51, 10.13, 7.30
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
root     pts/0    51.15.223.6      14:11   22:51   0.09s  0.09s -bash
root     pts/1    51.15.223.6      15:29    0.00s  0.06s  0.02s w
```

## see who logged on your system since last reboot

- using "last" : 
```
last
```

It also show when was last reboot.

result example : 
```
root     pts/1        51.15.223.6      Tue Oct 10 15:29   still logged in
root     pts/0        51.15.223.6      Tue Oct 10 14:11   still logged in
root     pts/0        51.15.223.6      Tue Oct 10 11:31 - 14:08  (02:37)
root     pts/0        51.15.223.6      Mon Oct  9 17:41 - 21:01  (03:20)
root     pts/0        51.15.223.6      Thu Jun 29 15:02 - 15:12  (00:09)
root     pts/0        51.15.223.6      Thu Jun 29 14:49 - 15:02  (00:12)
root     pts/0                         Mon May 15 17:29 - 14:49 (44+21:19)
root     pts/0                         Sun Apr 30 18:10 - 18:11  (00:00)
root     pts/0        51.15.223.6      Sat Apr 29 22:22 - 00:34  (02:12)
root     pts/0        109.190.117.17   Fri Apr 28 15:23 - 19:45  (04:22)
root     pts/0                         Fri Apr 28 10:44 - 15:23  (04:39)
root     pts/0        51.15.223.6      Fri Apr 28 01:23 - 03:36  (02:12)
root     pts/0        109.190.117.17   Thu Apr 27 20:17 - 22:31  (02:13)
root     pts/1        109.190.117.17   Thu Apr 27 13:22 - 20:09  (06:47)
root     pts/0        109.190.117.17   Thu Apr 27 09:23 - 20:09  (10:46)
root     pts/1        51.15.223.6      Thu Apr 27 08:24 - 08:24  (00:00)
root     pts/0        51.15.223.6      Thu Apr 27 01:45 - 08:24  (06:39)
reboot   system boot  5.15.102-1-pve   Thu Apr 27 01:44   still running
root     pts/1        51.15.223.6      Thu Apr 27 00:37 - down   (01:04)
root     pts/0        82.65.15.205     Thu Apr 27 00:24 - 00:49  (00:25)
reboot   system boot  5.15.102-1-pve   Thu Apr 27 00:22 - 01:41  (01:19)
```

## Source : 

- [linuxhandbook show logged user tutorial ](https://linuxhandbook.com/linux-logged-in-users/)