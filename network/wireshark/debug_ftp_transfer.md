# Debug FTP transfer

## Description

This document will describe the procedure in order to debug a ftp transfer (find what is causing issue).

You will need :
- A FTP server (filezilla is a free ftp server)
- A FTP client (filezilla is a free ftp client)
- Wireshark
- a file to send (or receive)

Before starting make sure to know how the FTP protocol works : [check FTP protocol wikipedia](https://fr.wikipedia.org/wiki/File_Transfer_Protocol).

## wireshark
```
src net 192.168.0.0/24 and (port 21)
```


## Source :

- [tutorial on analysing ftp with wireshark](https://xmehulx.github.io/terminal/wireshark-basic-tutorial-using-ftp-session)
- [another shorter tutorial on analysing ftp with wireshark](https://resources.infosecinstitute.com/topic/network-traffic-analysis-for-ir-ftp-protocol-with-wireshark/)
- [FTP protocol wikipédia](https://fr.wikipedia.org/wiki/File_Transfer_Protocol)