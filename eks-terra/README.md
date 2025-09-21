Terraform конфигурация:
1. Убедитесь, что AWS credentials доступны через env vars (AWS_ACCESS_KEY_ID
и AWS_SECRET_ACCESS_KEY)
2. Запустите:
 terraform init
 terraform apply -var 'aws_region=eu-central-1' -var
'cluster_name=student1-cluster'
3. После создания кластера можно получить доступ к kubectl с помощью awscli:
 aws eks update-kubeconfig --region eu-central-1 --name <cluster-name>
4. Helm релизы (ingress-nginx, argocd) тоже создаются через terraform
(helm_install.tf)
5.

