terraform {
  required_version = ">= 1.11"

  required_providers {
    assert = {
      source  = "hashicorp/assert"
      version = ">= 0.15"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.100"
    }
  }
}
