# Получаем данные о созданном EKS кластере
data "aws_eks_cluster" "cluster" {
    name = module.eks.cluster_id
}
data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_id
}
provider "kubernetes" {
    host = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token = data.aws_eks_cluster_auth.cluster.token
}
provider "helm" {
    kubernetes {
        host = data.aws_eks_cluster.cluster.endpoint
        cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
        token = data.aws_eks_cluster_auth.cluster.token
    }
}
# Namespace для ingress
resource "kubernetes_namespace" "ingress_nginx" {
    metadata {
        name = "ingress-nginx"
    }
}
# Helm release: ingress-nginx
resource "helm_release" "ingress_nginx" {
    name = "ingress-nginx"
    repository = "https://kubernetes.github.io/ingress-nginx"
    chart = "ingress-nginx"
    namespace = kubernetes_namespace.ingress_nginx.metadata[0].name
    version = "5.6.0" # пример; при необходимости обновите
    values = [
        <<EOF
    controller:
        service:
        type: LoadBalancer
EOF
]
}

# Namespace для ArgoCD
resource "kubernetes_namespace" "argocd" {
    metadata {
        name = "argocd"
}
}
# Helm release: ArgoCD
resource "helm_release" "argocd" {
    name = "argocd"
    repository = "https://argoproj.github.io/argo-helm"
    chart = "argo-cd"
    namespace = kubernetes_namespace.argocd.metadata[0].name
    version = "6.6.0" # пример; обновите при необходимости
    values = [
        <<EOF
server:
    ingress:
        enabled: true
        hosts:
        - argocd.${var.cluster_short}.${var.group_domain}
        annotations:
            kubernetes.io/ingress.class: "nginx"
EOF
]
}
