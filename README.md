# Terraform AWS 3-Tier Infrastructure

**Tagline: "Scalable, Secure, and Automated 3-Tier AWS Architecture with Terraform – Built for Reliability and DevOps Excellence"**

[![Terraform](https://img.shields.io/badge/Terraform-1.5+-blue.svg)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-orange.svg)](https://aws.amazon.com/)
[![GitHub Actions](https://img.shields.io/badge/CI/CD-GitHub%20Actions-green.svg)](https://github.com/features/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository provides a modular Terraform setup for deploying a secure 3-tier architecture on AWS, including VPC, ALB, EC2, RDS, and S3. It demonstrates best practices in IaC, multi-region deployment, CI/CD automation, and monitoring—ideal for showcasing cloud engineering skills.

## Architecture Overview

The project deploys a classic 3-tier stack:
- **Presentation Tier**: ALB for load balancing.
- **Application Tier**: EC2 instances for web/app logic.
- **Data Tier**: RDS for databases.
- **Extras**: VPC networking, S3 storage, IAM roles, CloudWatch monitoring, and multi-region support.

### Architecture Diagram
User --> ALB --> EC2 Instances --> RDS Database | | | v v v VPC IAM Roles S3 Bucket 
(Networking) (Security) (Storage) | v CloudWatch (Monitoring) | v Multi-Region Deployment (us-east-1, us-west-2) | v GitHub Actions (CI/CD)


## Key Features

- Modular Terraform modules for reusability.
- Multi-region AWS setup for high availability.
- Automated CI/CD with GitHub Actions.
- Security-focused with IAM, VPC, and CloudWatch.
- Scalable and production-ready.

## Prerequisites

- AWS account and CLI configured.
- Terraform 1.5+ installed.
- GitHub for CI/CD.

## Quick Start

1. Clone: `git clone https://github.com/yourusername/terraform-aws-3tier.git`
2. Init: `terraform init`
3. Plan: `terraform plan`
4. Apply: `terraform apply`
5. Access via ALB DNS output.

## Screenshots

Here are key visuals from the deployment process, demonstrating the infrastructure in action.

- **Terraform Plan and Apply Output**: Shows successful resource creation via Terraform CLI.
  ![Terraform Apply Output](images/terraform-apply.png)

- **AWS Console: EC2 Instances**: Displays running EC2 instances with custom tags.
  ![EC2 Instances](images/ec2-instances.png)

- **AWS Console: ALB Load Balancer**: Illustrates the ALB setup with healthy targets.
  ![ALB Load Balancer](images/alb-load-balancer.png)

- **AWS Console: RDS Database**: Confirms the database instance and endpoint.
  ![RDS Database](images/rds-database.png)

- **GitHub Actions Workflow**: Highlights automated CI/CD pipeline execution.
  ![GitHub Actions Workflow](images/github-actions-workflow.png)

##  Project Structure

terraform-aws-3tier/ ├── main.tf ├── variables.tf ├── outputs.tf ├── terraform.tf ├── modules/ (vpc, alb, ec2, rds, s3) ├── .github/workflows/deploy.yml └── README.md

## CI/CD

Uses GitHub Actions for automated deployment. Add AWS secrets to your repo for secure access.

## Contributing

Fork and submit PRs. Follow Terraform best practices.

## License

MIT License.




