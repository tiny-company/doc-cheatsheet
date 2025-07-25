# desktop env configuration

## Description

Usefull commands in order to set desktop environment

- Add Gnome desktop env :
```
services.xserver.enable = true;
services.xserver.desktopManager.gnome.enable = true;
```

- Add Plasma desktop env :
```
services.xserver.enable = true;
services.xserver.desktopManager.plasma5.enable = true;
```

- Add Plasma desktop env :
```
services.xserver.enable = true;
services.xserver.desktopManager.plasma5.enable = true;
```

- Add xfce desktop env :
```
services.xserver.enable = true;
services.xserver.desktopManager.xfce.enable = true;
```


After changes are made in configuration.nix : apply using `sudo nixos-rebuild switch` and log out