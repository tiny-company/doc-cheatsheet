# terraform cheatsheet

## Terraform troubleshooting command :

- Format and validate the config :
```
terraform fmt
```

- Validate terraform syntax :
```
terraform validate
```

- Check / test the terraform (To see what will be added/created/deleted without applying) :
```
terraform plan -var-file="terraform.tfvars.json"
```
- or to export the plan
```
terraform plan -var-file="terraform.tfvars.json" -out tfplan
```

- To show the plan in Human readable text (json) :
```
terraform show -json tfplan | jq > tfplan.json
```

- Execute the terraform project (following the plan, recommended way):
```
terraform apply tfplan
```

- Execute the terraform (with no plan):
```
terraform apply -var-file="terraform.tfvars.json"
```

- Destroy every ressources created through Terraform :
```
terraform destroy
```

- Destroy every ressources created through Terraform (without confirmation):
```
terraform destroy -auto-approve
```

## How to

- [Create multiple instance using count](https://www.bogotobogo.com/DevOps/Terraform/Terraform-creating-multiple-instances-count-list-type.php)
- [Article that explain way to manage secret in terraform](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#bebe)
- [Article that explain the backend usage for terraform state storage](https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa)

## tutorial and best practices

- [tutorial to create infra for multiple environement](https://www.digitalocean.com/community/tutorials/how-to-create-reusable-infrastructure-with-terraform-modules-and-templates#using-templates-for-customization)
- [tutorial to make terraform work with ansible](https://www.digitalocean.com/community/tutorials/how-to-use-ansible-with-terraform-for-configuration-management)
- [tutorial for using workspace to manage multiple environement](https://www.digitalocean.com/community/tutorials/how-to-deploy-multiple-environments-with-workspaces-in-your-terraform-project)
- [tutorial to protect sensitive data in terraform](https://www.digitalocean.com/community/tutorials/how-to-protect-sensitive-data-in-terraform)

## Documentation

### terraform

- [terraform function list](https://developer.hashicorp.com/terraform/language/functions)
- [terraform module documentation](https://developer.hashicorp.com/terraform/language/modules/syntax)

### cloudflare

- [cloudflare official documentation for terraform (on cloudflare website)](https://developers.cloudflare.com/terraform/)
- [terraform official documention for cloudflare (on terraform website)](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs)


### scaleway

- [terraform official documentation for scaleway](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs)
- [very good tutorial to deploy infrastucture on scaleway using terraform](https://www.scaleway.com/en/docs/tutorials/terraform-quickstart/#storing-the-terraform-state-in-the-cloud)
- [very good tutorial to manage and deploy instance on scaleway using terraform and serverless script](https://www.scaleway.com/en/docs/tutorials/manage-instances-with-terraform-and-functions/)