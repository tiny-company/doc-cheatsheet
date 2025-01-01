# Listening port/socket on srv

Find open port on the local srv (srv on which you are)

## method 1 : sudo netstat -ltup 

Better for showing IPv4 and IPv6

- cmd :
```
sudo netstat -lntup
```

Use grep to filter on specific process :
```
sudo netstat -lntup | grep "nginx"
```

## method 2 : sudo ss -lntu

Better for showing all ports open (like port use by docker process) :
```
ss -lntu
```

## Sources :

- Good tutorial to know what are open ports on host : https://www.tecmint.com/find-listening-ports-linux/
- Other good tutorial : https://www.geeksforgeeks.org/ways-to-find-out-list-of-all-open-ports-in-linux/