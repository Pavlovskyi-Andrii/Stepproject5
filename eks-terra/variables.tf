#переменные (имена, размеры, etc)

# AWS Configuration 
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

# Cluster Configuration
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "pavlovskyi"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.29"
}

# Domain Configuration
variable "domain_name" {
  description = "Base domain name"
  type        = string
  default     = "devops8.test-danit.com"
}

variable "group_number" {
  description = "Group number for domain"
  type        = string
  default     = "devops8"
}

# Node Configuration
variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t2.micro"
}

variable "node_desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 4
}

variable "node_max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}

variable "node_min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 4
}

# ArgoCD Configuration
variable "argocd_admin_password" {
  description = "ArgoCD admin password"
  type        = string
  default     = "admin123!"
  sensitive   = true
}

variable "argocd_version" {
  description = "ArgoCD Helm chart version"
  type        = string
  default     = "5.46.8"
}

# Feature Flags
variable "enable_external_dns" {
  description = "Enable External DNS"
  type        = bool
  default     = true
}

variable "enable_metrics_server" {
  description = "Enable Metrics Server"
  type        = bool
  default     = true
}

variable "enable_cert_manager" {
  description = "Enable Cert Manager"
  type        = bool
  default     = false
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

# Tags
variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "development"
    Project     = "StepProject5"
    Terraform   = "true"
  }
}

# Load Balancer Controller
variable "aws_load_balancer_controller_version" {
  description = "AWS Load Balancer Controller Helm chart version"
  type        = string
  default     = "1.6.2"
}

# External DNS
variable "external_dns_version" {
  description = "External DNS Helm chart version"
  type        = string
  default     = "1.13.1"
}

# Metrics Server
variable "metrics_server_version" {
  description = "Metrics Server Helm chart version"
  type        = string
  default     = "3.11.0"
}
# Domain Configuration (дополнительно)
variable "cluster_short" {
  description = "Short name of the cluster for DNS"
  type        = string
  default     = "pavlovskyi"
}

variable "group_domain" {
  description = "Group domain name"
  type        = string
  default     = "devops8.test-danit.com"
}
