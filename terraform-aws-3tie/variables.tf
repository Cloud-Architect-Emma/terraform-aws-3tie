variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "regions" {
  description = "List of regions for multi-region deployment"
  type        = list(string)
  default     = ["us-east-1", "us-west-2"]
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Add more: e.g., instance_type, db_password (use sensitive=true for secrets)
