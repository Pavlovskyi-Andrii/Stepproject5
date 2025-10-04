variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "domain_name" {
  description = "Domain name for DNS management"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC Provider ARN"
  type        = string
  default     = null
}

variable "oidc_issuer" {
  description = "OIDC Issuer URL"
  type        = string
  default     = ""
}
