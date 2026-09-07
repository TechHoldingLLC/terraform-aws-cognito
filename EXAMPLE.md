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

## Passkey / WebAuthn sign-in
Lets users sign in with a passkey (Face ID, Touch ID, Windows Hello, or a physical security key)
instead of, or alongside, a password. `sign_in_policy` controls which first factors are offered -
`WEB_AUTHN` must be in that list for passkeys to actually work, and `explicit_auth_flows` needs
`ALLOW_USER_AUTH` so the client can use the choice-based sign-in flow that offers them.
```
module "cognito" {
  source = "./cognito"
  name   = "example-dev"

  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_AUTH",
  ]

  sign_in_policy = ["PASSWORD", "WEB_AUTHN"]

  web_authn_configuration = {
    relying_party_id  = "example.com"   # domain the passkey is bound to
    user_verification = "preferred"     # or "required" to force biometric/PIN, not just device possession
  }
}
```

## Sending Cognito emails through your own SES domain, with a custom template
By default Cognito sends its own sign-up/forgot-password/etc. emails through its built-in sender
(capped at 50/day, no SPF/DKIM). Switching `email_sending_account` to `DEVELOPER` routes them
through your own verified SES identity instead. `custom_message` is optional on top of that - it
lets a Lambda supply the actual subject/HTML for each of those emails (Cognito still sends the
email itself; the Lambda only renders the content, via `event.response.emailSubject`/`emailMessage`).
```
module "cognito" {
  source = "./cognito"
  name   = "example-dev"

  email_configuration = {
    email_sending_account = "DEVELOPER"
    from_email_address    = "no-reply@example.com"
    source_arn            = "arn:aws:ses:us-west-2:123456789012:identity/example.com"
  }

  custom_message = "arn:aws:lambda:us-west-2:123456789012:function:example-cognito-custom-message"
}
```
