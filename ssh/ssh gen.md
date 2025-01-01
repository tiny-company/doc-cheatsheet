# Generate ssh keys

- How to generate ssh keys tutorial : https://www.ssh.com/academy/ssh/keygen

- to generate a basic ssh keys :
```
ssh-keygen -t rsa -b 4096 -f "test" -C "comment"
```

- to generate strong ssh key pair :
```
ssh-keygen -t ecdsa -b 521 -f ~/.ssh/strong_key -C "strong_key"
```

## Source :

- generate ssh key for github : https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent