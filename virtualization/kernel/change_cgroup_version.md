# Change cgroup version

## on ubuntu to use cgroup V1

- at below parameter to GRUB_CMDLINE_LINUX var in "/etc/default/grub" :
```
sudo sed -i '/^GRUB_CMDLINE_LINUX/ s/"$/ cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1"/' /etc/default/grub
```

- Then update the grub (reboot might also be needed if not working) : 
```
sudo update-grub
```

- check cgroup version available :
```
mount | grep '^cgroup' | awk '{print $1}' | uniq
```


## Source :

- [topic to change cgroup version](https://askubuntu.com/questions/1237813/enabling-memory-cgroup-in-ubuntu-20-04)