## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_identity_pool.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_pool) | resource |
| [aws_cognito_user_pool.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |
| [aws_iam_role.cognito_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cognito_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [random_password.external_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_iam_policy_document.cognito_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cognito_sns_trust_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token_validity"></a> [access\_token\_validity](#input\_access\_token\_validity) | Time limit, between 5 minutes and 1 day, after which the access token is no longer valid and cannot be used | `number` | `5` | no |
| <a name="input_account_recovery"></a> [account\_recovery](#input\_account\_recovery) | Define which verified available method a user can use to recover their forgotten password | <pre>list(object({<br>    name     = string<br>    priority = number<br>  }))</pre> | `[]` | no |
| <a name="input_allow_software_mfa_token"></a> [allow\_software\_mfa\_token](#input\_allow\_software\_mfa\_token) | Enable software mfa token | `bool` | `false` | no |
| <a name="input_allow_unauthenticated_identities"></a> [allow\_unauthenticated\_identities](#input\_allow\_unauthenticated\_identities) | Whether the identity pool supports unauthenticated logins or not | `bool` | `false` | no |
| <a name="input_allowed_oauth_flows"></a> [allowed\_oauth\_flows](#input\_allowed\_oauth\_flows) | List of allowed OAuth flows | `list(string)` | `[]` | no |
| <a name="input_allowed_oauth_flows_user_pool_client"></a> [allowed\_oauth\_flows\_user\_pool\_client](#input\_allowed\_oauth\_flows\_user\_pool\_client) | Whether the client is allowed to follow the OAuth protocol when interacting with Cognito user pools | `bool` | `false` | no |
| <a name="input_allowed_oauth_scopes"></a> [allowed\_oauth\_scopes](#input\_allowed\_oauth\_scopes) | List of allowed OAuth scopes | `list(string)` | `[]` | no |
| <a name="input_attributes_verification_before_update"></a> [attributes\_verification\_before\_update](#input\_attributes\_verification\_before\_update) | A list of attributes requiring verification before update | `list(string)` | `[]` | no |
| <a name="input_auto_verified_attributes"></a> [auto\_verified\_attributes](#input\_auto\_verified\_attributes) | Attributes to be auto-verified | `list(string)` | `[]` | no |
| <a name="input_callback_url"></a> [callback\_url](#input\_callback\_url) | List of allowed callback URLs for the identity providers | `list(string)` | `[]` | no |
| <a name="input_email_configuration"></a> [email\_configuration](#input\_email\_configuration) | Email configuartion | <pre>object({<br>    configuartion_set      = optional(string)<br>    email_sending_account  = optional(string)<br>    from_email_address     = optional(string)<br>    reply_to_email_address = optional(string)<br>    source_arn             = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_enable_token_revocation"></a> [enable\_token\_revocation](#input\_enable\_token\_revocation) | Enables or disables token revocation | `bool` | `false` | no |
| <a name="input_explicit_auth_flows"></a> [explicit\_auth\_flows](#input\_explicit\_auth\_flows) | List of authentication flows | `list(string)` | `[]` | no |
| <a name="input_id_token_validity"></a> [id\_token\_validity](#input\_id\_token\_validity) | Time limit, between 5 minutes and 1 day, after which the ID token is no longer valid and cannot be used | `number` | `5` | no |
| <a name="input_mfa_configuartion"></a> [mfa\_configuartion](#input\_mfa\_configuartion) | Multi-Factor Authentication (MFA) configuration for the User Pool | `string` | `"OFF"` | no |
| <a name="input_minimum_length"></a> [minimum\_length](#input\_minimum\_length) | Minimum length of the password policy that you have set | `number` | `8` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of user pool | `any` | n/a | yes |
| <a name="input_post_authentication"></a> [post\_authentication](#input\_post\_authentication) | Post-confirmation AWS Lambda trigger | `string` | `""` | no |
| <a name="input_pre_sign_up"></a> [pre\_sign\_up](#input\_pre\_sign\_up) | Pre-registration AWS Lambda trigger | `string` | `""` | no |
| <a name="input_prevent_user_existence_errors"></a> [prevent\_user\_existence\_errors](#input\_prevent\_user\_existence\_errors) | Choose which errors and responses are returned by Cognito APIs during authentication, account confirmation, and password recovery when the user does not exist in the user pool | `string` | `"ENABLED"` | no |
| <a name="input_refresh_token_validity"></a> [refresh\_token\_validity](#input\_refresh\_token\_validity) | Time limit, between 60 minutes and 10 years, after which the refresh token is no longer valid and cannot be used | `number` | `1` | no |
| <a name="input_require_lowercase"></a> [require\_lowercase](#input\_require\_lowercase) | Whether you have required users to use at least one lowercase letter in their password | `bool` | `true` | no |
| <a name="input_require_numbers"></a> [require\_numbers](#input\_require\_numbers) | Whether you have required users to use at least one number in their password | `bool` | `true` | no |
| <a name="input_require_symbols"></a> [require\_symbols](#input\_require\_symbols) | Whether you have required users to use at least one symbol in their password | `bool` | `true` | no |
| <a name="input_require_uppercase"></a> [require\_uppercase](#input\_require\_uppercase) | Whether you have required users to use at least one uppercase letter in their password | `bool` | `true` | no |
| <a name="input_schema"></a> [schema](#input\_schema) | schema attributes of a user pool | `list(any)` | `[]` | no |
| <a name="input_sms_configuration"></a> [sms\_configuration](#input\_sms\_configuration) | Enable sms configuration | `bool` | `false` | no |
| <a name="input_supported_identity_providers"></a> [supported\_identity\_providers](#input\_supported\_identity\_providers) | List of provider names for the identity providers that are supported on this client | `list(string)` | `[]` | no |
| <a name="input_temporary_password_validity_days"></a> [temporary\_password\_validity\_days](#input\_temporary\_password\_validity\_days) | number of days a temporary password is valid | `number` | `7` | no |
| <a name="input_token_units"></a> [token\_units](#input\_token\_units) | units in which the validity times are represented in | `map(any)` | `{}` | no |
| <a name="input_username_attributes"></a> [username\_attributes](#input\_username\_attributes) | Whether email addresses or phone numbers can be specified as usernames when a user signs up | `list(string)` | `[]` | no |
| <a name="input_username_configuration"></a> [username\_configuration](#input\_username\_configuration) | Whether username case sensitivity will be applied for all users in the user pool through Cognito APIs | `bool` | `true` | no |
| <a name="input_verification_message_template"></a> [verification\_message\_template](#input\_verification\_message\_template) | verification message template | <pre>object({<br>    default_email_option  = optional(string)<br>    email_subject         = optional(string)<br>    email_message         = optional(string)<br>    email_message_by_link = optional(string)<br>    email_subject_by_link = optional(string)<br>    sms_message           = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_user_pool_arn"></a> [user\_pool\_arn](#output\_user\_pool\_arn) | n/a |
| <a name="output_user_pool_domain"></a> [user\_pool\_domain](#output\_user\_pool\_domain) | n/a |
| <a name="output_user_pool_endpoint"></a> [user\_pool\_endpoint](#output\_user\_pool\_endpoint) | n/a |
| <a name="output_user_pool_id"></a> [user\_pool\_id](#output\_user\_pool\_id) | n/a |