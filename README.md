# fiap-video-infraestrutura
AWS Infraestrutura terraform (EKS, RDS, SQS, SES entre outros serviços)

Este repositório utiliza Github Actions para automatizar o deploy das configurações terraform.

**Para ativar e desativar o cluster k8s e todos os recursos provisionados por este repositório, basta alterar o arquivo config.json e abrir pull request para a alteração na branch main.**

### Executar Local
Lembre-se de configurar ./aws/credentials e configurar variaveis de ambiente:

```
export AWS_ACCESS_KEY_ID=....
export AWS_SECRET_ACCESS_KEY=....
```

### Comandos úteis
```
terraform init
terraform fmt
terraform validate

# Aplicar configurações
terraform apply

# Destruir configurações
terraform destroy
```
### Conectar kubectl ao cluster
`aws eks update-kubeconfig --region us-east-1 --name fiap-video-k8s`

`kubectl get svc` 
