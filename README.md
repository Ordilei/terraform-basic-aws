# Basic VPC

Configuration in this directory creates set of VPC resources which may be sufficient for staging or production environment (look into [vpc](./vpc) for more info or structure used).

There are public, private, subnets, and NAT Gateways created in each availability zone.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan -var-file=env.tfvars
$ terraform apply -var-file=env.tfvars
```

For Destroy this recipe execute

```bash
$ terraform destroy -var-file=env.tfvars
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.35 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.35 |


## Inputs

Create em env.tfvars for execute this recipe, this contains key value.

| Key | Description |
|------|-------------|
| <a name="aws_account_id"></a> [aws\_account\_id](#aws\_account\_id) | Set Account id AWS |
| <a name="vpc_cidr_block"></a> [vpc\_cidr\_block](#vpc\_cidr\_block) | Define Cidr for vpc AWS |
| <a name="aws_region"></a> [aws\_region](#aws\_region) | Define region AWS |


