terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      # 6.0 is the floor that carries user_pool_tier on aws_cognito_user_pool.
      version = ">= 6.0"
    }
  }
}
