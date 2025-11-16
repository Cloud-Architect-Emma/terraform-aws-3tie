# Terraform AWS 3-Tier Infrastructure

**Tagline: "Scalable, Secure, and Automated 3-Tier AWS Architecture with Terraform – Built for Reliability and DevOps Excellence"**

[![Terraform](https://img.shields.io/badge/Terraform-1.5+-blue.svg)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-orange.svg)](https://aws.amazon.com/)
[![GitHub Actions](https://img.shields.io/badge/CI/CD-GitHub%20Actions-green.svg)](https://github.com/features/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository demonstrates a production-ready, modular Terraform project for deploying a **3-tier architecture** on AWS. It showcases industry-standard practices in Infrastructure as Code (IaC), including modular design, multi-region deployment, automated CI/CD, and robust monitoring. Perfect for DevOps engineers, cloud architects, and recruiters seeking evidence of AWS expertise, Terraform proficiency, and scalable system design.

##  Architecture Overview

The infrastructure deploys a classic 3-tier application stack:
- **Presentation Tier**: Application Load Balancer (ALB) distributing traffic to EC2 instances.
- **Application Tier**: EC2 instances running application logic (e.g., a simple web server).
- **Data Tier**: RDS database for persistent storage.
- **Supporting Components**: VPC with networking, S3 for static assets, IAM roles for security, CloudWatch for monitoring, and multi-region redundancy.

### Architecture Diagram

```mermaid
graph TD
    A[User] --> B[ALB (Public)]
    B --> C[EC2 Instances (Web/App Servers)]
    C --> D[RDS (Database)]
    E[VPC] --> F[Subnets: Public/Private]
    F --> B
    F --> C
    F --> D
    G[S3 Bucket] --> C
    H[IAM Roles] --> C
    I[CloudWatch] --> C
    J[Multi-Region] --> E
    K[GitHub Actions] --> L[Terraform Apply]
    L --> E
