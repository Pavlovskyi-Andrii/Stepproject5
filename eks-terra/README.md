
## StepProject5 - EKS GitOps Інфраструктура
## Огляд Повна EKS інфраструктура з ArgoCD для GitOps деплою.

## Архітектура
EKS кластер з воркер-нодами

ArgoCD для GitOps

AWS Load Balancer Controller

External DNS для автоматичного управління DNS

SSL сертифікати через ACM (або Let's Encrypt)

Metrics Server для HPA (Horizontal Pod Autoscaler)

## Передумови
Налаштований AWS CLI

Terraform >= 1.0

kubectl

## Розгортання
Initialize Terraform
terraform init

Plan deployment
terraform plan

Deploy infrastructure
terraform apply

Configure kubectl
aws eks update-kubeconfig --region eu-central-1 --name student1

## Components
- **EKS Cluster**: Managed Kubernetes cluster
- **ArgoCD**: GitOps deployment tool
- **ALB Controller**: AWS Load Balancer integration
- **External DNS**: Automatic DNS record management
- **ACM**: SSL certificate management

## Accessing Services
- ArgoCD: http://argocd.student1.devops8.test-danit.com/
- Application: https://app.student1.devops8.test-danit.com
