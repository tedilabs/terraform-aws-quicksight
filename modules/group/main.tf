locals {
  metadata = {
    package = "terraform-aws-quicksight"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
}

data "aws_caller_identity" "this" {}

locals {
  account_id = data.aws_caller_identity.this.account_id
}


###################################################
# QuickSight Group
###################################################

resource "aws_quicksight_group" "this" {
  count = var.type == "INTERNAL" ? 1 : 0

  namespace   = var.namespace
  group_name  = var.name
  description = var.description

  aws_account_id = local.account_id
}

data "aws_quicksight_group" "this" {
  count = var.type == "EXTERNAL" ? 1 : 0

  namespace  = var.namespace
  group_name = var.name

  aws_account_id = local.account_id
}

locals {
  group = var.type == "INTERNAL" ? aws_quicksight_group.this[0] : data.aws_quicksight_group.this[0]
}

resource "aws_quicksight_group_membership" "this" {
  for_each = toset(var.members)

  namespace   = local.group.namespace
  group_name  = local.group.group_name
  member_name = each.value

  aws_account_id = local.account_id
}


###################################################
# QuickSight Role Membership
###################################################

resource "aws_quicksight_role_membership" "this" {
  count = var.role != null ? 1 : 0

  namespace   = var.namespace
  role        = var.role
  member_name = local.group.group_name

  aws_account_id = local.account_id
}
