# my_aws_resources


# Development

![Github license](https://img.shields.io/badge/license-None-blue.svg)

git clone git@github.com:Toogii2019/my_aws_resources.git

## Resource diagram

<img src="Untitled Diagram.png" width="500" height="300">

## Load modules and initialize

cd terraform && terraform init  

## Sync resources

terraform refresh -var-file dev.tfvars

## Plan resources to be created

terraform plan -var-file dev.tfvars

## Deploy resources

terraform deploy -var-file dev.tfvars

## Destroy resources

terraform destroy -var-file dev.tfvars
