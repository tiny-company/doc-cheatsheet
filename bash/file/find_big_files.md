# Find big files

## Find the biggest file/directory :

- To find the 10 biggest folders in current directory:
```
du -h -d 1 | sort -hr | head -n 10
```

- To find the 10 biggest files and folders in current directory:
```
du -ah | sort -hr | head -n 10
```
[source link](https://linuxhandbook.com/find-biggest-files-linux/)

- Find the largest file in linux : `du -ah /* 2>/dev/null | sort -rh | head -n 10`

Explanation :
First we are going to look at how we can find the largest directories and files in linux combined, execute the following command to find the top 10 largest directories and files

## Find biggest directory and except specific directory

- sort 10 biggest directories from / but don't show /data directory :
```
du -h / | grep -v "/data" | sort -hr |  head -n 10
```

## Sources :

- https://www.linux.com/training-tutorials/find-large-files-linux/
- https://www.howtouselinux.com/post/find-largest-files-and-directories-in-linux