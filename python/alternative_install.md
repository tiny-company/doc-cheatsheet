# python alternative install

## make altinstall

when compiling python from source instead of running `make install` run `make altinstall` in order to install a new python version instead of overwriting existing one.

## update alternatives

In order to define which python version to run, use `update-alternative` to set an alias.

Exemple :
```
update-alternatives --set python3 /usr/local/bin/python3.11
```