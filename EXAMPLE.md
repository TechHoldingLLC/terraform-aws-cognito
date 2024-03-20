# Cognito
Below are the examples of calling this module.

## Create Cognito User Pool
Pass below inputs according to your requirements.
```
module "cognito" {
  source                   = "./cognito"
  name                     = "example-dev"
  username_attributes      = ["email"]    # If this is not present then "User name" will be used for Cognito user pool sign-in options
  auto_verified_attributes = ["email", "phone_number"]     # When phone_number is included, enable sms_configuration
  username_configuration   = false     # Use this when "username_attributes" is not present and you want to keep case_sensitive = false, default is true
  mfa_configuartion        = "OPTIONAL"
  allow_software_mfa_token = true
  sms_configuration        = true
  pre_sign_up              = "ARN of presignup lambda function"
  post_authentication      = "ARN of post authentication lambda function"

  verification_message_template = {
    default_email_option  = "CONFIRM_WITH_LINK"
    email_subject_by_link = "Verification code"
    email_message_by_link = "Verification link is {##Click Here##}"
  }

  minimum_length                   = 10
  require_lowercase                = false
  require_numbers                  = false
  require_symbols                  = false
  require_uppercase                = false
  temporary_password_validity_days = 9

  email_configuration = {
    email_sending_account  = "COGNITO_DEFAULT"
    reply_to_email_address = "noreply@example.com"
  }

  account_recovery = [
    {
      name     = "verified_email"
      priority = 1
    }
  ]

  # Attributes can be added, but not modified or removed
  schema = [   # Name must be 20 characters or fewer
    {
      name                = "string_type"  # default value will be used for min_length and max_length
      attribute_data_type = "String"
      mutable             = true 
    },
    {
      name                = "custom_string_type"
      attribute_data_type = "String"
      mutable             = true
      min_length          = 0
      max_length          = 1024
    },
    {
      name                = "number_type" # default value will be used for min_value and max_value
      attribute_data_type = "Number"
      mutable             = true
    },
    {
      name                = "custom_number_type"
      attribute_data_type = "Number"
      mutable             = true
      min_value           = 0
      max_value           = 8
    }
  ]
}
```

## Cognito User Pool Client
By default the units for access_token_validity and id_token_validity is hours and default unit for refresh_token_validity is days. Specify token_units to change the units. Pass below inputs according to your requirements with above inputs.
```
module "cognito" {
  source                               = "./cognito"
  name                                 = "example-dev"
  callback_url                         = [ "https://example.com" ]
  enable_token_revocation              = true
  allowed_oauth_flows_user_pool_client = true    # AllowedOAuthFlows and AllowedOAuthScopes are required if user pool client is allowed to use OAuth flows.
  allowed_oauth_flows                  = [ "code" ]
  allowed_oauth_scopes                 = [ "email", "phone", "openid" ]     # Requires openid to be selected when adding email, phone and profile
  supported_identity_providers         = [ "COGNITO" ]

  token_units = {
    access_token = "minutes"
    id_token = "minutes"
    refresh_token = "hours"
  }
}
```
