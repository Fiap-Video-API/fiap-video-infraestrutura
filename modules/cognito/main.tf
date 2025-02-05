# Configuração do provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Cria uma política para o Amazon Cognito
resource "aws_iam_policy" "cognito_full_access" {
  name        = "CognitoFullAccess"
  description = "Permite acesso total ao Amazon Cognito"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "cognito-idp:CreateUserPool",
          "cognito-idp:CreateUserPoolClient",
          "cognito-idp:CreateUserPoolDomain",
          "cognito-idp:DescribeUserPool",
          "cognito-idp:UpdateUserPool",
          "cognito-idp:DeleteUserPool",
          "cognito-idp:ListUserPools"
        ]
        Resource = "*"
      }
    ]
  })
}

# Anexa a política ao usuário fiap-video
resource "aws_iam_user_policy_attachment" "cognito_access" {
  user       = "fiap-video"
  policy_arn = aws_iam_policy.cognito_full_access.arn
}

# Cria o User Pool do Cognito
resource "aws_cognito_user_pool" "user_pool" {
  name                     = "FiapVideoPool"
  alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_uppercase                = true
    require_numbers                  = true
    require_symbols                  = false
    temporary_password_validity_days = 7
  }

  schema {
    name                = "email"
    attribute_data_type = "String"
    mutable             = false
    required            = true
  }

  schema {
    name                = "custom:lgpdConsent"
    attribute_data_type = "String"
    mutable             = true
    required            = false
  }

  tags = {
    Environment = "dev"
  }
}

# Cria o Client do User Pool
resource "aws_cognito_user_pool_client" "app_client" {
  name                          = "FiapVideoAppClient"
  user_pool_id                  = aws_cognito_user_pool.user_pool.id
  explicit_auth_flows           = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  prevent_user_existence_errors = "ENABLED"
  generate_secret               = false
  supported_identity_providers  = ["COGNITO"]
}

# Cria o Domínio do User Pool
resource "aws_cognito_user_pool_domain" "cognito_domain" {
  domain       = "fiapvideo-cognito"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

# Outputs
output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "cognito_client_id" {
  value = aws_cognito_user_pool_client.app_client.id
}

output "cognito_jwks_url" {
  value = "https://cognito-idp.${var.aws_region}.amazonaws.com/${aws_cognito_user_pool.user_pool.id}/.well-known/jwks.json"
}

# Variável para a região
variable "aws_region" {
  default = "us-east-1"
}