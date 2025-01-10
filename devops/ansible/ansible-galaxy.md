# ansible-galaxy cheatsheet

## remove all installed ansible role

- Donb't forget to change path according to where ansible role are installed
```
ansible-galaxy role remove $(ls /home/USERNAME/.ansible/roles | xargs)
```