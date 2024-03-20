variable "account_recovery" {
  description = "Define which verified available method a user can use to recover their forgotten password"
  type = list(object({
    name     = string
    priority = number
  }))
  default = []
}

variable "access_token_validity" {
  description = "Time limit, between 5 minutes and 1 day, after which the access token is no longer valid and cannot be used"
  type        = number
  default     = 5
}

variable "allowed_oauth_flows_user_pool_client" {
  description = "Whether the client is allowed to follow the OAuth protocol when interacting with Cognito user pools"
  type        = bool
  default     = false
}

variable "allowed_oauth_flows" {
  description = "List of allowed OAuth flows"
  type        = list(string)
  default     = []
}

variable "allowed_oauth_scopes" {
  description = "List of allowed OAuth scopes"
  type        = list(string)
  default     = []
}

variable "allow_software_mfa_token" {
  description = "Enable software mfa token"
  type        = bool
  default     = false
}

variable "allow_unauthenticated_identities" {
  description = "Whether the identity pool supports unauthenticated logins or not"
  type        = bool
  default     = false
}

variable "attributes_verification_before_update" {
  description = "A list of attributes requiring verification before update"
  type        = list(string)
  default     = []
}

variable "auto_verified_attributes" {
  description = "Attributes to be auto-verified"
  type        = list(string)
  default     = []
}

variable "callback_url" {
  description = "List of allowed callback URLs for the identity providers"
  type        = list(string)
  default     = []
}

variable "deletion_protection" {
  description = "DeletionProtection prevents accidental deletion of your user pool"
  type        = string
  default     = "ACTIVE"
}

variable "email_configuration" {
  description = "Email configuartion"
  type = object({
    configuartion_set      = optional(string)
    email_sending_account  = optional(string)
    from_email_address     = optional(string)
    reply_to_email_address = optional(string)
    source_arn             = optional(string)
  })
  default = {}
}

variable "enable_token_revocation" {
  description = "Enables or disables token revocation"
  type        = bool
  default     = false
}

variable "explicit_auth_flows" {
  description = "List of authentication flows"
  type        = list(string)
  default     = []
}

variable "id_token_validity" {
  description = "Time limit, between 5 minutes and 1 day, after which the ID token is no longer valid and cannot be used"
  type        = number
  default     = 5
}

variable "mfa_configuartion" {
  description = "Multi-Factor Authentication (MFA) configuration for the User Pool"
  type        = string
  default     = "OFF"
}

variable "minimum_length" {
  description = "Minimum length of the password policy that you have set"
  type        = number
  default     = 8
}

variable "name" {
  description = "Name of user pool"
}

variable "pre_sign_up" {
  description = "Pre-registration AWS Lambda trigger"
  type        = string
  default     = ""
}

variable "prevent_user_existence_errors" {
  description = "Choose which errors and responses are returned by Cognito APIs during authentication, account confirmation, and password recovery when the user does not exist in the user pool"
  type        = string
  default     = "ENABLED"
}

variable "post_authentication" {
  description = "Post-confirmation AWS Lambda trigger"
  type        = string
  default     = ""
}

variable "require_lowercase" {
  description = "Whether you have required users to use at least one lowercase letter in their password"
  type        = bool
  default     = true
}

variable "require_numbers" {
  description = "Whether you have required users to use at least one number in their password"
  type        = bool
  default     = true
}

variable "require_symbols" {
  description = "Whether you have required users to use at least one symbol in their password"
  type        = bool
  default     = true
}

variable "require_uppercase" {
  description = "Whether you have required users to use at least one uppercase letter in their password"
  type        = bool
  default     = true
}

variable "refresh_token_validity" {
  description = "Time limit, between 60 minutes and 10 years, after which the refresh token is no longer valid and cannot be used"
  type        = number
  default     = 1
}

variable "schema" {
  description = "schema attributes of a user pool"
  type        = list(any)
  default     = []
}

variable "sms_configuration" {
  description = "Enable sms configuration"
  type        = bool
  default     = false
}

variable "supported_identity_providers" {
  description = "List of provider names for the identity providers that are supported on this client"
  type        = list(string)
  default     = []
}

variable "temporary_password_validity_days" {
  description = "number of days a temporary password is valid"
  type        = number
  default     = 7
}

variable "token_units" {
  description = "units in which the validity times are represented in"
  type        = map(any)
  default     = {}
}

variable "username_attributes" {
  description = "Whether email addresses or phone numbers can be specified as usernames when a user signs up"
  type        = list(string)
  default     = []
}

variable "username_configuration" {
  description = "Whether username case sensitivity will be applied for all users in the user pool through Cognito APIs"
  type        = bool
  default     = true
}

variable "verification_message_template" {
  description = "verification message template"
  type = object({
    default_email_option  = optional(string)
    email_subject         = optional(string)
    email_message         = optional(string)
    email_message_by_link = optional(string)
    email_subject_by_link = optional(string)
    sms_message           = optional(string)
  })
  default = {}
}
