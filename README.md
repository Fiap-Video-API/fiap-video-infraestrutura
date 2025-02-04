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


# Criar usuário Cognito

- Criar usuário
```
aws cognito-idp admin-create-user \
    --user-pool-id <USER_POOL_ID> \
    --username <name> \
    --user-attributes Name="email",Value="email@email.com" Name="custom:lgpdConsent",Value="true"
```

- Alterar senha permanente:
```
  aws cognito-idp admin-set-user-password \
    --user-pool-id <USER_POOL_ID> \
    --username usuario123 \
    --password "NovaSenha@123" \
    --permanent
```

- Obter JWT
```
aws cognito-idp initiate-auth \
  --auth-flow USER_PASSWORD_AUTH \
  --client-id <APP_CLIENT_ID> \
  --auth-parameters USERNAME="usuario123",PASSWORD="Senha@123"
```


