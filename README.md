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


### AWS 3-Tier Architecture Diagram

+-------------------+     +-------------------+     +-------------------+
|     User          | --> |   ALB (Public)    | --> |  EC2 Instances    |
|                   |     |  Load Balancer    |     |  (Web/App Servers)|
+-------------------+     +-------------------+     +-------------------+                                    v                           v
                        +-------------------+     +-------------------+
                        |   VPC Networking  |     |   RDS Database    |
                        | - Subnets (Pub/Priv)|     |  (MySQL/PostgreSQL)|
                        | - Security Groups |     +-------------------+
                        | - IGW/NAT         |
                        +-------------------+
                                  |
                                  v
                        +-------------------+     +-------------------+
                        |   Supporting      |     |   Multi-Region    |
                        |   Components      |     |   (us-east-1,     |
                        | - S3 Bucket       |     |    us-west-2)     |
                        | - IAM Roles       |     +-------------------+
                        | - CloudWatch      |
                        +-------------------+
                                  ^
                                  |
                        +-------------------+
                        | GitHub Actions    |
                        | (CI/CD Pipeline)  |
                        +-------------------+
                                      
