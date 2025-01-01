# Read certificate

## Checking the Status of a Certificate (openSSL)

```
openssl x509 -in mycert.pem -text -noout
```

## Using OpenSSL to View the Status of a Website’s Certificate

```
openssl s_client -connect linuxhandbook.com:443 2>/dev/null | openssl x509 -noout -dates
```

## Source : 

- good tutorial about openssl command to manage certificate : https://linuxhandbook.com/check-certificate-openssl/