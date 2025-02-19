# configure users

## create a new user

- create a new user for terraform :
```
pveum user add terraform-prov@pve --password <password>
```

## Assign role to user :

- assign "TerraformRole" role to user "terraform" :

```
pveum aclmod / -user terraform@pve -role TerraformRole
```