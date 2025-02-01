# Cognito
resource "aws_cognito_user_pool" "user_pool" {
  name = "fiap-video-user-pool"

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
  }

  auto_verified_attributes = ["email"]
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "fiap-video-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  explicit_auth_flows = ["ADMIN_NO_SRP_AUTH"]
}