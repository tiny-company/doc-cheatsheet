
## SSH agent
> For Avoiding entering your ssh password for the private key, add it to the ssh agent :

```
eval $(ssh-agent -s)
ssh-add -t 3h /path_to_your_private_key
```

This example will start the ssh-agent in background and add your key to it and register the key and the password associated for 3 hours.

