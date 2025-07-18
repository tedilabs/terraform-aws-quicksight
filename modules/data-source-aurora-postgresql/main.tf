locals {
  metadata = {
    package = "terraform-aws-quicksight"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}

data "aws_caller_identity" "this" {}

locals {
  account_id = data.aws_caller_identity.this.account_id

  role_actions = {
    "OWNER" = [
      "quicksight:PassDataSource",
      "quicksight:DescribeDataSourcePermissions",
      "quicksight:UpdateDataSource",
      "quicksight:UpdateDataSourcePermissions",
      "quicksight:DescribeDataSource",
      "quicksight:DeleteDataSource",
    ]
    "USER" = [
      "quicksight:PassDataSource",
      "quicksight:DescribeDataSourcePermissions",
      "quicksight:DescribeDataSource",
    ]
  }
}


###################################################
# QuickSight Data Source - Aurora PostgreSQL
###################################################

resource "aws_quicksight_data_source" "this" {
  aws_account_id = local.account_id

  data_source_id = var.name
  name           = var.display_name
  type           = "AURORA_POSTGRESQL"


  ## Data Source
  parameters {
    aurora_postgresql {
      database = var.parameters.database
      host     = var.parameters.host
      port     = var.parameters.port
    }
  }

  credentials {
    dynamic "credential_pair" {
      for_each = var.credentials.type == "CREDENTIAL_PAIR" ? [var.credentials.credential_pair] : []

      content {
        username = credential_pair.value.username
        password = credential_pair.value.password
      }
    }
    copy_source_arn = var.credentials.type == "COPY_DATA_SOURCE" ? var.credentials.data_source : null
    secret_arn      = var.credentials.type == "SECRETS_MANAGER" ? var.credentials.secrets_manager_secret : null
  }


  ## Network
  dynamic "vpc_connection_properties" {
    for_each = var.vpc_connection.enabled ? [var.vpc_connection] : []

    content {
      vpc_connection_arn = vpc_connection_properties.value.arn
    }
  }

  ssl_properties {
    disable_ssl = !var.ssl.enabled
  }


  ## Access Control
  dynamic "permission" {
    for_each = var.permissions

    content {
      principal = permission.value.principal
      actions = (permission.value.role != null
        ? local.role_actions[permission.value.role]
        : permission.value.actions
      )
    }
  }


  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
