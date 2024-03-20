module "cognito" {
  source = "../"

  name                                  = "example-dev"
  username_attributes                   = ["email"]
  auto_verified_attributes              = ["email"]
  attributes_verification_before_update = ["email"]

  account_recovery = [
    {
      name     = "verified_email"
      priority = 1
    }
  ]

  schema = [
    {
      name                = "email"
      attribute_data_type = "String"
      mutable             = true
      required            = true
      max_length          = 2048
      min_length          = 0
    },
    {
      name                = "name"
      attribute_data_type = "String"
      mutable             = true
      required            = true
      max_length          = 2048
      min_length          = 0
    }
  ]

  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]

  enable_token_revocation       = true
  prevent_user_existence_errors = "ENABLED"

  ## Hosted UI
  allowed_oauth_flows_user_pool_client = true
  callback_url                         = [ "https://example.com" ]
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid"]
  supported_identity_providers         = ["COGNITO"]

  refresh_token_validity = 30
  access_token_validity  = 1
  id_token_validity      = 1

  token_units = {
    refresh_token = "days"
    access_token  = "hours"
    id_token      = "hours"
  }
}
