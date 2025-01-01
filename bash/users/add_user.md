# Add user on linux 


- Add user with "useradd" cmd : 
```
sudo useradd -s /bin/bash -m -c "Mary Quinn" -Gsambashare maryq
```

- sudo: We need administrator privileges to allow a new user to access the computer.
- useradd: The useradd command.
- -s /bin/bash: The shell option. This sets the default shell for this new user.
- -m: The make home directory option. This creates a directory in the “/home/” directory, with the same name as the new user account name.
- -c “Mary Quinn”: The full name of the new user. This is optional.
- -Gsambashare: The additional group option. This is optional. The new user is added to a group with the same name as their account name. The -G option (note, capital “G”) adds the user to supplementary groups. The groups must already exist. We’re also making the new user a member of the “sambashare” group.
- maryq: The name of the new user account. This must be unique. It cannot already be in use for another user.

- example for a classic docker user : 
```
sudo useradd -g docker -m  -u 1001 -c "docker user" docker
```

-m : to create home directory 
-u : set the user UID

## Sources : 

- [tutorial from howtogeek to add user on linux](https://www.howtogeek.com/806104/add-a-user-to-linux/)
- [adduser manual](https://linux.die.net/man/8/adduser)