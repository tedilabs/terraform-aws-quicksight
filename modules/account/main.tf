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
# QuickSight Account Subscription
###################################################

# INFO: Not supported attributes
# - `contact_number`
# - `email_address`
# - `first_name`
# - `last_name`
resource "aws_quicksight_account_subscription" "this" {
  account_name = var.name
  edition      = var.edition

  notification_email = var.notification_email


  ### Authentication
  authentication_method = var.authentication_method

  ## Active Directory
  active_directory_name = (var.authentication_method == "ACTIVE_DIRECTORY" && var.active_directory != null
    ? var.active_directory.name
    : null
  )
  realm = (var.authentication_method == "ACTIVE_DIRECTORY" && var.active_directory != null
    ? var.active_directory.realm
    : null
  )
  directory_id = (var.authentication_method == "ACTIVE_DIRECTORY" && var.active_directory != null
    ? var.active_directory.directory_id
    : null
  )

  ## IAM Identity Center
  iam_identity_center_instance_arn = (var.authentication_method == "IAM_IDENTITY_CENTER" && var.iam_identity_center != null
    ? var.iam_identity_center.instance
    : null
  )

  ## Role Memberships
  admin_group = (contains(["ACTIVE_DIRECTORY", "IAM_IDENTITY_CENTER"], var.authentication_method)
    ? var.role_memberships.admin
    : null
  )
  author_group = (contains(["ACTIVE_DIRECTORY", "IAM_IDENTITY_CENTER"], var.authentication_method) && length(var.role_memberships.author) > 0
    ? var.role_memberships.author
    : null
  )
  reader_group = (contains(["ACTIVE_DIRECTORY", "IAM_IDENTITY_CENTER"], var.authentication_method) && length(var.role_memberships.reader) > 0
    ? var.role_memberships.reader
    : null
  )
  # TODO: Not supported yet
  # admin_pro_group                  = var.admin_pro_group
  # author_pro_group                 = var.author_pro_group
  # reader_pro_group                 = var.reader_pro_group

  aws_account_id = local.account_id
}


###################################################
# QuickSight Account Settings
###################################################

resource "aws_quicksight_account_settings" "this" {
  default_namespace              = var.default_namespace
  termination_protection_enabled = var.termination_protection_enabled

  aws_account_id = aws_quicksight_account_subscription.this.aws_account_id
}
