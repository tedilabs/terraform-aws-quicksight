provider "aws" {
  region = "us-east-1"
}


###################################################
# QuickSight Namespaces
###################################################

module "namespace__3rd_party" {
  source = "../../modules/namespace"
  # source  = "tedilabs/quicksight/aws//modules/namespace"
  # version = "~> 0.3.0"

  name           = "3rd-party"
  identity_store = "QUICKSIGHT"

  tags = {
    "project" = "terraform-aws-quicksight-examples"
  }
}


###################################################
# QuickSight Groups
###################################################

module "group__dev" {
  source = "../../modules/group"
  # source  = "tedilabs/quicksight/aws//modules/group"
  # version = "~> 0.3.0"

  name        = "dev"
  description = "Dev Group."
  namespace   = "default"

  members = []
}

module "group__ops" {
  source = "../../modules/group"
  # source  = "tedilabs/quicksight/aws//modules/group"
  # version = "~> 0.3.0"

  name        = "ops"
  description = "Ops Group."
  namespace   = "default"

  members = []
}

module "group__3rd_party" {
  source = "../../modules/group"
  # source  = "tedilabs/quicksight/aws//modules/group"
  # version = "~> 0.3.0"

  name        = "3rd-party"
  description = "3rd-party Group."
  namespace   = module.namespace__3rd_party.name

  members = []
}
