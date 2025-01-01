# APT

## Usage

- resolve error on incorrectly installed package "dpkg: error processing package <package name> (--configure): E: Sub-process /usr/bin/dpkg returned an error code (1)" :

```
sudo dpkg --remove --force-remove-reinstreq <package name>
sudo apt --fix-broken install
```

## Sources :

- [stackoverflow article](https://stackoverflow.com/questions/70437760/issue-with-dpkg-when-trying-fix-broken-with-apt)