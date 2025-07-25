# Search Packages

## search package on machine

- search using nix-env :
```
nix-env -qaP package_name
```

nix-env: Invokes the Nix environment management tool.
-q: Indicates that you are querying for packages.
-a: Specifies that you want to search through all available packages.
-P: Requests that the output includes the attribute paths of the packages.
'package_name': The search term, which in this case is looking for packages related to "vim."

Additional Options
    --json: If you add this option, the output will be formatted as JSON, which can be useful for programmatic access or further processing.
