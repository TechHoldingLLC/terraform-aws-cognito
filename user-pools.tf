resource "random_password" "external_id" {
  length           = 10
  special          = true
  override_special = "19OX7"
}

resource "aws_cognito_user_pool" "main" {
  name                     = var.name
  deletion_protection      = var.deletion_protection
  username_attributes      = var.username_attributes
  auto_verified_attributes = var.auto_verified_attributes
  mfa_configuration        = var.mfa_configuartion

  dynamic "account_recovery_setting" {
    for_each = var.account_recovery

    content {
      recovery_mechanism {
        name     = account_recovery_setting.value.name
        priority = account_recovery_setting.value.priority
      }
    }
  }

  password_policy {
    minimum_length                   = var.minimum_length
    require_lowercase                = var.require_lowercase
    require_numbers                  = var.require_numbers
    require_symbols                  = var.require_symbols
    require_uppercase                = var.require_uppercase
    temporary_password_validity_days = var.temporary_password_validity_days
  }

  username_configuration {
    case_sensitive = var.username_configuration
  }

  user_attribute_update_settings {
    attributes_require_verification_before_update = var.attributes_verification_before_update
  }

  dynamic "software_token_mfa_configuration" {
    for_each = var.allow_software_mfa_token ? [true] : []

    content {
      enabled = true
    }
  }

  dynamic "sms_configuration" {
    for_each = var.sms_configuration ? [true] : []

    content {
      external_id    = random_password.external_id.result
      sns_caller_arn = aws_iam_role.cognito_sns.arn
    }
  }

  dynamic "verification_message_template" {
    for_each = length(var.verification_message_template) > 0 ? [var.verification_message_template] : []

    content {
      default_email_option  = lookup(verification_message_template.value, "default_email_option", "CONFIRM_WITH_CODE")
      email_subject         = lookup(verification_message_template.value, "email_subject", null)
      email_message         = lookup(verification_message_template.value, "email_message", null)
      email_message_by_link = lookup(verification_message_template.value, "email_message_by_link", null)
      email_subject_by_link = lookup(verification_message_template.value, "email_subject_by_link", null)
      sms_message           = lookup(verification_message_template.value, "sms_message", null)
    }
  }

  dynamic "email_configuration" {
    for_each = length(var.email_configuration) > 0 ? [var.email_configuration] : []

    content {
      configuration_set      = lookup(email_configuration.value, "configuration_set", null)
      email_sending_account  = lookup(email_configuration.value, "email_sending_account", null)
      from_email_address     = lookup(email_configuration.value, "from_email_address", null)
      reply_to_email_address = lookup(email_configuration.value, "reply_to_email_address", null)
      source_arn             = lookup(email_configuration.value, "source_arn", null)
    }
  }

  lambda_config {
    pre_sign_up         = var.pre_sign_up
    post_authentication = var.post_authentication
  }

  # Required attributes
  dynamic "schema" { # Attributes can be added, but not modified or removed
    for_each = var.schema

    content {
      name                     = schema.value.name
      attribute_data_type      = schema.value.attribute_data_type
      developer_only_attribute = try(schema.value.developer_only_attribute, false)
      mutable                  = try(schema.value.mutable, true)
      required                 = try(schema.value.required, false)

      dynamic "string_attribute_constraints" {
        for_each = schema.value.attribute_data_type == "String" ? [true] : []

        content {
          min_length = lookup(schema.value, "min_length", 0)
          max_length = lookup(schema.value, "max_length", 2048)
        }
      }

      dynamic "number_attribute_constraints" {
        for_each = schema.value.attribute_data_type == "Number" ? [true] : []

        content {
          min_value = lookup(schema.value, "min_value", 0)
          max_value = lookup(schema.value, "max_value", pow(2, 1023))
        }
      }
    }
  }
}

resource "aws_cognito_user_pool_client" "main" {
  name                                 = var.name
  user_pool_id                         = aws_cognito_user_pool.main.id
  explicit_auth_flows                  = var.explicit_auth_flows
  access_token_validity                = var.access_token_validity
  id_token_validity                    = var.id_token_validity
  refresh_token_validity               = var.refresh_token_validity
  callback_urls                        = var.callback_url
  enable_token_revocation              = var.enable_token_revocation
  prevent_user_existence_errors        = var.prevent_user_existence_errors
  allowed_oauth_flows_user_pool_client = var.allowed_oauth_flows_user_pool_client
  allowed_oauth_flows                  = var.allowed_oauth_flows
  allowed_oauth_scopes                 = var.allowed_oauth_scopes
  supported_identity_providers         = var.supported_identity_providers

  dynamic "token_validity_units" {
    for_each = length(var.token_units) > 0 ? [var.token_units] : []

    content {
      access_token  = lookup(token_validity_units.value, "access_token", "hours")
      id_token      = lookup(token_validity_units.value, "id_token", "hours")
      refresh_token = lookup(token_validity_units.value, "refresh_token", "days")
    }
  }
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = var.name
  user_pool_id = aws_cognito_user_pool.main.id
}
