# Aguamiel

This project is intended to practice provisioning AWS resources via Terraform.

**Happy coding!**

---

## 🚀 Getting Started

### Prepare Variables

Create a `terraform.tfvars` file with the following content, updating the values to suit your environment:

```hcl
avail_zone              = "selected-availability-zone"
env_prefix              = "any-env-prefix"
ingress_cidr_blocks     = ["your-public-ip-address/32"]
instance_type           = "the-aws-instance-type"
subnet_cidr_block       = "cidr-block-for-your-subnet"
vpc_cidr_block          = "cidr-block-for-your-vpc"
ssh_public_key_location = "path-to-your-public-key"
```

### Install providers and modules

```hcl
terraform init
```

## Plan and Apply

```hcl
terraform plan

terraform apply
```
