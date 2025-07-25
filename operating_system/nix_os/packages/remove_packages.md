# remove packages

## Garbage collection

When you uninstall a package like this…
```
nix-env --uninstall firefox
```

the package isn’t deleted from the system right away (after all, you might want to do a rollback, or it might be in the profiles of other users). Instead, unused packages can be deleted safely by running the garbage collector:
```
nix-collect-garbage
```
This deletes all packages that aren’t in use by any user profile or by a currently running program.

## Sources :

- [nix official documentation](https://nixos.org/guides/how-nix-works/)