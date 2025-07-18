variable "name" {
  description = "(Required) An identifier for the QuickSight data source. This ID is a unique identifier for each AWS Region in an AWS account."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "(Optional) The display name for the QuickSight data source, maximum of 128 characters."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.display_name) <= 128
    error_message = "Data source name must be 128 characters or less."
  }
}

variable "parameters" {
  description = <<EOF
  (Required) A configuration for parameters used to connect to the Aurora PostgreSQL data source. `parameters` as defined below.
    (Required) `database` - The name of the Aurora PostgreSQL database to connect to.
    (Required) `host` - The hostname of the Aurora PostgreSQL database server.
    (Optional) `port` - The port number for the Aurora PostgreSQL database server. Defaults to `5432`.
  EOF
  type = object({
    database = string
    host     = string
    port     = optional(number, 5432)
  })
  nullable = false

  validation {
    condition     = var.parameters.port >= 1 && var.parameters.port <= 65535
    error_message = "The value for `port` must be between `1` and `65535`."
  }
}

variable "credentials" {
  description = <<EOF
  (Required) A confiruation for credentials which Amazon QuickSight uses to connect to the data source. `credentials` as defined below.
    (Optional) `type` - The type of credentials to use. Valid values are `CREDENTIAL_PAIR`, `COPY_DATA_SOURCE`, or `SECRETS_MANAGER`. Defaults to `SECRETS_MANAGER`.
    (Optional) `credential_pair` - Credential pair with `username` and `password`.
    (Optional) `data_source` - The ARN of a data source that has the credential pair to use.
    (Optional) `secrets_manager_secret` - The ARN of the secret in AWS Secrets Manager containing the credentials.
  EOF
  type = object({
    type = optional(string, "SECRETS_MANAGER")
    credential_pair = optional(object({
      username = string
      password = string
    }))
    data_source            = optional(string)
    secrets_manager_secret = optional(string)
  })
  nullable  = false
  sensitive = true

  validation {
    condition = anytrue([
      var.credentials.type != "CREDENTIAL_PAIR",
      var.credentials.type == "CREDENTIAL_PAIR" && var.credentials.credential_pair != null,
    ])
    error_message = "If `type` is set to `CREDENTIAL_PAIR`, then `credential_pair` must be provided."
  }
  validation {
    condition = anytrue([
      var.credentials.type != "COPY_DATA_SOURCE",
      var.credentials.type == "COPY_DATA_SOURCE" && var.credentials.data_source != null,
    ])
    error_message = "If `type` is set to `COPY_DATA_SOURCE`, then `data_source` must be provided."
  }
  validation {
    condition = anytrue([
      var.credentials.type != "SECRETS_MANAGER",
      var.credentials.type == "SECRETS_MANAGER" && var.credentials.secrets_manager_secret != null,
    ])
    error_message = "If `type` is set to `SECRETS_MANAGER`, then `secrets_manager_secret` must be provided."
  }
}

variable "permissions" {
  description = <<EOF
  (Optional) A list of resource permissions on the data source. Maximum of 64 items. Each item of `permissions` as defined below.
    (Required) `principal` - The Amazon Resource Name (ARN) of the principal. This can be one of the following:
      - The ARN of an Amazon QuickSight user or group associated with a data source or dataset. (This is common.)
      - The ARN of an Amazon QuickSight user, group, or namespace associated with an analysis, dashboard, template, or theme. (This is common.)
      - The ARN of an Amazon Web Services account root: This is an IAM ARN rather than a QuickSight ARN. Use this option only to share resources (templates) across Amazon Web Services accounts. (This is less common.)
    (Optional) `role` - A role of principal with a pre-defined set of permissions. Valid values are `OWNER` and `USER`. Conflicting with `actions`.
    (Optional) `actions` - A set of IAM actions to grant or revoke permissions on. Maximum of 16 items. Conflicting with `role`.
  EOF
  type = list(object({
    principal = string
    role      = optional(string)
    actions   = optional(set(string), [])
  }))
  default  = []
  nullable = false

  validation {
    condition     = length(var.permissions) <= 64
    error_message = "Maximum of 64 permissions can be specified."
  }
  validation {
    condition = alltrue([
      for permission in var.permissions :
      contains(["OWNER", "USER"], permission.role) || length(permission.actions) > 0
    ])
    error_message = "Valid values for `permission.role` are `OWNER` and `USER`. If `role` is not set, then `actions` must be specified."
  }
  validation {
    condition = alltrue([
      for permission in var.permissions :
      length(permission.actions) <= 16
    ])
    error_message = "Maximum of 16 actions can be specified per permission."
  }
}

variable "vpc_connection" {
  description = <<EOF
  (Optional) A configuration for VPC connection of the data source. `vpc_connection` as defined below.
    (Optional) `enabled` - Whether to use a VPC connection for the data source. Defaults to `false`.
    (Optional) `arn` - The Amazon Resource Name (ARN) for the VPC connection.
  EOF
  type = object({
    enabled = optional(bool, false)
    arn     = optional(string, null)
  })
  default  = {}
  nullable = false

  validation {
    condition = anytrue([
      var.vpc_connection.enabled == false,
      var.vpc_connection.enabled == true && var.vpc_connection.arn != null,
    ])
    error_message = "If VPC connection is enabled, the ARN must be provided."
  }
}

variable "ssl" {
  description = <<EOF
  (Optional) A configuration for SSL (Secure Socket Layer) properties that apply when Amazon QuickSight connects to the data source. `ssl` as defined below.
    (Optional) `enabled` - Whether to use SSL for the connection. Defaults to `true`.
  EOF
  type = object({
    enabled = optional(bool, true)
  })
  default  = {}
  nullable = false
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "(Optional) Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
  nullable    = false
}

variable "resource_group_name" {
  description = "(Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}
