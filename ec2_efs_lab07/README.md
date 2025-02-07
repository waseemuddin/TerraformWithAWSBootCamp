# Terraform AWS EFS + EC2 Setup

This repository contains Terraform modules to create an **Amazon EFS (Elastic File System)** and mount it on an **EC2 instance** in AWS. The infrastructure is designed using a **modular approach** for reusability and scalability.

---

## Architecture Overview

The setup includes:
1. **VPC**: A virtual private cloud with public subnets.
2. **Security Groups**: For EC2 (SSH access) and EFS (NFS access).
3. **EFS**: A scalable, shared file system for centralized storage.
4. **EC2 Instance**: An Amazon Linux 2 instance with EFS auto-mounted at boot.

---

## Prerequisites

1. **AWS Account**: Ensure you have an AWS account with the necessary permissions.
2. **Terraform Installed**: Install Terraform from [here](https://www.terraform.io/downloads.html).
3. **AWS CLI Installed**: Install and configure the AWS CLI with your credentials:
   ```bash
   aws configure


4. **Git**: Install Git to clone this repository.
```bash
terraform-aws-efs-ec2/
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── security_groups/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── efs/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf