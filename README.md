#Terraform AWS 3-Tier Infrastructure
**Tagline: "Scalable, Secure, and Automated 3-Tier AWS Architecture with Terraform – Built for Reliability and DevOps Excellence"

**Terraform AWS GitHub Actions License:** MIT

This repository demonstrates a production-ready, modular Terraform project for deploying a 3-tier architecture on AWS. It showcases industry-standard practices in Infrastructure as Code (IaC), including modular design, multi-region deployment, automated CI/CD, and robust monitoring. Perfect for DevOps engineers, cloud architects, and recruiters seeking evidence of AWS expertise, Terraform proficiency, and scalable system design.

##**Architecture Overview**
The infrastructure deploys a classic 3-tier application stack:

Presentation Tier: Application Load Balancer (ALB) distributing traffic to EC2 instances.
Application Tier: EC2 instances running application logic (e.g., a simple web server).
Data Tier: RDS database for persistent storage.
Supporting Components: VPC with networking, S3 for static assets, IAM roles for security, CloudWatch for monitoring, and multi-region redundancy.

##**Architecture Diagram**

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
...

Multi-Region: Deploy identical stacks in multiple AWS regions (e.g., us-east-1 and us-west-2) for high availability.
Security: VPC isolation, security groups, IAM least-privilege roles, and encrypted RDS.
Automation: CI/CD pipeline for automated planning and deployment.
✨ Features
Modular Design: Reusable Terraform modules for VPC, ALB, EC2, RDS, and S3 – promotes DRY principles and maintainability.
Multi-Region Deployment: Easily scale across regions using Terraform workspaces and provider aliases.
CI/CD Integration: GitHub Actions for automated testing, planning, and deployment with Terraform Cloud or S3 backend.
Monitoring & Security: CloudWatch alarms, IAM roles (e.g., SSM for EC2 management), and VPC networking automation.
Scalability: Auto-scaling groups (extensible), load balancing, and RDS read replicas.
Best Practices: Version control with Git, remote state management, input validation, and documentation.
Recruiter-Ready: Demonstrates skills in AWS (EC2, VPC, ALB, RDS, S3, IAM, CloudWatch), Terraform (modules, providers, backends), and DevOps (CI/CD, automation).
📋 Prerequisites
AWS Account: Free tier eligible; configure with AWS CLI (aws configure).
Terraform: Version 1.5+ (download from terraform.io).
GitHub Account: For CI/CD (optional for local testing).
Tools: AWS CLI, Git, and a code editor (e.g., VS Code).
Permissions: IAM user with policies like AmazonEC2FullAccess, AmazonRDSFullAccess, etc. (use least-privilege in production).
🚀 Quick Start
Clone the Repository:

bash

Copy code
git clone https://github.com/yourusername/terraform-aws-3tier.git
cd terraform-aws-3tier
Configure Backend:

For Terraform Cloud: Update terraform.tf with your organization/workspace.
For S3: Uncomment the S3 backend block and create a bucket.
Initialize and Deploy:

bash

Copy code
terraform init
terraform plan
terraform apply
Access the Application: Use the output alb_dns to visit your ALB endpoint.

Clean Up:

bash

Copy code
terraform destroy
For multi-region: Use workspaces (terraform workspace select prod) and re-apply.

📁 Project Structure

Copy code
terraform-aws-3tier/
├── main.tf                 # Main configuration (calls modules)
├── variables.tf            # Input variables (e.g., regions, instance types)
├── outputs.tf              # Outputs (e.g., ALB DNS, RDS endpoint)
├── terraform.tf            # Providers and backend config
├── modules/                # Reusable modules
│   ├── vpc/                # VPC, subnets, security groups
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── alb/                # Application Load Balancer
│   ├── ec2/                # EC2 instances with IAM and CloudWatch
│   ├── rds/                # RDS database
│   └── s3/                 # S3 bucket for static assets
├── .github/workflows/      # GitHub Actions CI/CD
│   └── deploy.yml
└── README.md               # This file
🛠️ Terraform Snippets
Main Configuration (main.tf)
hcl

Copy code
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  region   = var.region
}

module "ec2" {
  source    = "./modules/ec2"
  subnet_id = module.vpc.public_subnet_id
  count     = 2
}

module "alb" {
  source     = "./modules/alb"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
}

module "rds" {
  source      = "./modules/rds"
  db_password = var.db_password
  sg_id       = module.vpc.db_sg_id
}

# Multi-region example
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

module "vpc_west" {
  providers = { aws = aws.west }
  source    = "./modules/vpc"
  vpc_cidr  = var.vpc_cidr
  region    = "us-west-2"
}
VPC Module (modules/vpc/main.tf)
hcl

Copy code
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "3tier-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
EC2 Module with IAM and CloudWatch (modules/ec2/main.tf)
hcl

Copy code
resource "aws_iam_role" "ec2_role" {
  name = "ec2-ssm-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id  # Use data source for latest AMI
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [var.sg_id]
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    echo "Hello from 3-Tier EC2" > /var/www/html/index.html
  EOF
  tags = {
    Name = "web-server"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name          = "high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_actions       = []  # Add SNS topic ARN for notifications
}
RDS Module (modules/rds/main.tf)
hcl

Copy code
resource "aws_db_instance" "main" {
  allocated_storage      = 20
  engine                 = "mysql"
  instance_class         = "db.t2.micro"
  db_name                = "mydb"
  username               = "admin"
  password               = var.db_password
  vpc_security_group_ids = [var.sg_id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  skip_final_snapshot    = true
  tags = {
    Name = "3tier-rds"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group"
  subnet_ids = var.private_subnet_ids
}
🔄 CI/CD with GitHub Actions
Automate deployments with .github/workflows/deploy.yml:

yaml

Copy code
name: Terraform CI/CD
on:
  push:
    branches: [ main ]
jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: hashicorp/setup-terraform@v2
      - name: Configure AWS
        run: |
          aws configure set aws_access_key_id ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws configure set aws_secret_access_key ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      - name: Terraform Init
        run: terraform init
      - name: Terraform Plan
        run: terraform plan
      - name: Terraform Apply
        if: github.ref == 'refs/heads/main'
        run: terraform apply -auto-approve
Add AWS credentials as GitHub secrets for secure access.

🤝 Contributing
Contributions welcome! Fork the repo, create a feature branch, and submit a PR. Follow Terraform best practices (e.g., terraform fmt and terraform validate).

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.
