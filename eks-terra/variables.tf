variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "student1"
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.29"
}

variable "cluster_short" {
  description = "Short name for the cluster (used in DNS)"
  type        = string
  default     = "student1"
}

variable "group_domain" {
  description = "Domain for the group (замените devops1 на номер вашей группы)"
  type        = string
  default     = "devops8.test-danit.com"
}
