# AWS Multi-account, Multi-region Bootstrapping with Terraform

This repository provides a modularized Terraform configuration to automate AWS Organizations, including creating Organizational Units (OUs) and accounts, along with an IAM policy for managing the organization.

## Directory Structure

```bash
aws_organizations/
├── main.tf
├── modules/
│   ├── account/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   ├── organization/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   └── ou/
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
├── outputs.tf
├── providers.tf
├── variables.tf

```

## Prerequisites

- Terraform installed on your local machine.
- AWS CLI configured with appropriate permissions.
- An existing AWS account with the necessary permissions to create and manage AWS Organizations.

## Step-by-Step Guide

### Step 1: Clone the Repository

```sh
git clone https://github.com/waseemuddin/TerraformWithAWSBootCamp.git

# switch brach "aws_ou_examples"
git checkout aws_ou_examples

terraform init

terraform validate

terraform plan

terraform apply ## or --auto-apply

---
```

![efs img-02](/ou-lab03/images/aws_ou.png)
