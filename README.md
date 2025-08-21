# Aguamiel

A terraform module that provide a stack of AWS resources to streamline the creation of high availability environments for http backend services using ALB and autoscaling.

## The problem

The setup of an aws environment for a http backend service require the creation, connection and configuration of many aws resources.

## The solution

A terraform module that setup needed resources to host backend services.

It implements best practices of security, high availability and monitoring so you focus on the configuration management and creation of pipelines for the service.

## 🚀 Setup instructions

### Parameters

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

Install providers and modules:

```hcl
terraform init
```

Then plan and apply:

```hcl
terraform plan

terraform apply
```