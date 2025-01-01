# show user infos 

## list all users on host :

```
awk -F':' '{ print $1}' /etc/passwd
```

## List user with UID on host :

```
awk -F':' '{ print $1}{ print $3}' /etc/passwd
```

- Quick reminder about users in linux :
    - System users are entities created by the system to run non-interactive processes, i.e., the processes that run in the background and do not require human interaction. The most important system user is root, which possesses administrative privileges.
    - Normal users are human users created by root or another user with root privileges. Each normal user has a login shell and a home directory to store their files.

## to show the UID range for normal user :

```
grep -E '^UID_MIN|^UID_MAX' /etc/login.defs
```

This show by default :

```
UID_MIN                  1000
UID_MAX                 60000
```

Explanation of the result :
The output in this example shows that the smallest UID a normal user can receive is 1000, and the largest is 60000.
System user might have UID less than 1000 (example : mail have UID : 8)

## shearch user by id 

```
id -nu [number]
```
