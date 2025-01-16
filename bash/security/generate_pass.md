# generate password 

## Generate hash with openssl 

- To generate random bytes (length : 20) with openssl :
```shell
openssl rand -hex 20
```

- To generate the random password in base64 with openssl :
```shell
openssl rand -base64 20
```

- To print the output to a file rather than standard output, add the -out flag to the command like the following:
```shell
openssl rand -out output.txt -base64 20
```


## Generate password hash with openssl 

- The openssl passwd command can be used for generating password hashes. For example, to generate password hash using MD5 based BSD password algorithm, use the following command :
```shell
openssl passwd -1 yourpass
```

## Sources : 

- [openssl rand – Generate random numbers and passwords](https://www.misterpki.com/openssl-rand/)
- [Generate Password Hash using OpenSSL](https://lindevs.com/generate-password-hash-using-openssl)