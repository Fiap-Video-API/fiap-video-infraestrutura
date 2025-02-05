resource "aws_cognito_user_pool" "user_pool" {
  name                     = "FiapVideoUserPoolFinal"
  alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length                   = 6
    require_lowercase                = true
    require_uppercase                = true
    require_numbers                   = true
    require_symbols                   = false
    temporary_password_validity_days  = 7
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    mutable                  = false
    required                 = true
  }

  schema {
    name                     = "lgpdConsent"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = false
  }

  tags = {
    Environment = "fiap-video-user-pool"
  }
}

resource "aws_cognito_user_pool_client" "app_client" {
  name                         = "FiapVideoAppClientFinal"
  user_pool_id                 = aws_cognito_user_pool.user_pool.id
  explicit_auth_flows          = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  prevent_user_existence_errors = "ENABLED"
  generate_secret              = false
  supported_identity_providers = ["COGNITO"]

  read_attributes = ["email", "custom:lgpdConsent"]
  write_attributes = ["email", "custom:lgpdConsent"]
}
