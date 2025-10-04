output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks.cluster_certificate_authority_data
}

output "vpc_id" {
  description = "VPC where the cluster is deployed"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private subnets for the EKS cluster"
  value       = module.vpc.private_subnets
}

output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${var.aws_region} update-kubeconfig --name ${var.cluster_name}"
}

output "argocd_url" {
  description = "ArgoCD server URL"
  value = "https://argocd.pavlovskyi.devops8.test-danit.com"
}

output "argocd_admin_password_command" {
  description = "Command to get ArgoCD admin password"
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d"
}

output "ingress_controller_external_ip" {
  description = "External IP of the ingress controller"
  value       = "Run: kubectl get svc -n ingress-nginx ingress-nginx-controller"
}
