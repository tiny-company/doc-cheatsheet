# send email with shell

## Description

- send email using shell (swaks command) :
```
 swaks --to <mail_address> \
      --from <mail_address> \
      --server <mail servrt address> \
      --tls \
      --auth LOGIN \
      --auth-user <mail_address> \
      --auth-password <password> \
      --data "From: <mail_address>\nDate: $(date -R)\nSubject: Test Email\n\nThis is the body of the email."
```