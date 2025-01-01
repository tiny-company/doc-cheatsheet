# groups cmd for linux 

## show groups

- to show groups in which you current user is :
```
groups 
``` 

- to show all groups 
```
cat /etc/groups
```

## add new group 

```
sudo groupadd new_group_name
```

## add a user to a group :

- with adduser cmd :
```
sudo adduser user_name new_group
```

- With usermod cmd :
```
sudo usermod –a –G group_name user_name
```
The usermod command uses the –append and –group options to append the user to a particular group. Without using –append, the user could be dropped from other groups.


## change group ownership of files

```
chgrp [option] groupname file/directory
```

A brief explanation of each option is shown below:

-c Display verbose output only after the change is made.
-f Suppress most error messages
-v Show diagnostic for every processed file.
-R Apply ownership on files and directories recursively.


## Remove a User From a Group

```
sudo gpasswd –d user_name new_group
``` 

## Delete a group 

```
sudo groupdel new_group
```

## sources :

- [tutorialfrom howtogeek about adding group on linux](https://www.howtogeek.com/50787/add-a-user-to-a-group-or-second-group-on-linux/)