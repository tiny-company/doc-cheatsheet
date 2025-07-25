# Configuration cheatsheet

## Description

Find here usefull commands about nix configuration usage

## Change configuration (don't apply on boot)

- to build the configuration and switch the running system to it, but without making it the boot default. So if (say) the configuration locks up your machine, you can just reboot to get back to a working configuration :
```
nixos-rebuild test --use-remote-sudo
```

## Change configuration (apply on boot)

- To change or apply existing configuration in the default `etc/nixos/configuration.nix` :
```
nixos-rebuild switch
```

## change configuration file

> Note : default configuration file is /etc/nixos/configuration.nix

- switch between configuration file :
```
sudo nixos-rebuild switch -I nixos-config=~/nixos-configs/configuration1.nix
```

## how to list previous version

- list all generation
```
sudo nix-env --list-generations
```

## how to rollback to previous (latest) configuration version (generation)

- rollback to previous configuration version
```
sudo nixos-rebuild switch --rollback
```

## how to rollback to a specific generation

- rollback to a specific generation id :
```
sudo nixos-rebuild switch --generation <N>
```