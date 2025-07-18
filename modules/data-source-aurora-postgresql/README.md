# data-source-aurora-postgresql

This module creates following resources.

- `aws_quicksight_data_source`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.100 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_quicksight_data_source.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/quicksight_data_source) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_credentials"></a> [credentials](#input\_credentials) | (Required) A confiruation for credentials which Amazon QuickSight uses to connect to the data source. `credentials` as defined below.<br/>    (Optional) `type` - The type of credentials to use. Valid values are `CREDENTIAL_PAIR`, `COPY_DATA_SOURCE`, or `SECRETS_MANAGER`. Defaults to `SECRETS_MANAGER`.<br/>    (Optional) `credential_pair` - Credential pair with `username` and `password`.<br/>    (Optional) `data_source` - The ARN of a data source that has the credential pair to use.<br/>    (Optional) `secrets_manager_secret` - The ARN of the secret in AWS Secrets Manager containing the credentials. | <pre>object({<br/>    type = optional(string, "SECRETS_MANAGER")<br/>    credential_pair = optional(object({<br/>      username = string<br/>      password = string<br/>    }))<br/>    data_source            = optional(string)<br/>    secrets_manager_secret = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | (Optional) The display name for the QuickSight data source, maximum of 128 characters. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) An identifier for the QuickSight data source. This ID is a unique identifier for each AWS Region in an AWS account. | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | (Required) A configuration for parameters used to connect to the Aurora PostgreSQL data source. `parameters` as defined below.<br/>    (Required) `database` - The name of the Aurora PostgreSQL database to connect to.<br/>    (Required) `host` - The hostname of the Aurora PostgreSQL database server.<br/>    (Optional) `port` - The port number for the Aurora PostgreSQL database server. Defaults to `5432`. | <pre>object({<br/>    database = string<br/>    host     = string<br/>    port     = optional(number, 5432)<br/>  })</pre> | n/a | yes |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | (Optional) A list of resource permissions on the data source. Maximum of 64 items. Each item of `permissions` as defined below.<br/>    (Required) `principal` - The Amazon Resource Name (ARN) of the principal. This can be one of the following:<br/>      - The ARN of an Amazon QuickSight user or group associated with a data source or dataset. (This is common.)<br/>      - The ARN of an Amazon QuickSight user, group, or namespace associated with an analysis, dashboard, template, or theme. (This is common.)<br/>      - The ARN of an Amazon Web Services account root: This is an IAM ARN rather than a QuickSight ARN. Use this option only to share resources (templates) across Amazon Web Services accounts. (This is less common.)<br/>    (Optional) `role` - A role of principal with a pre-defined set of permissions. Valid values are `OWNER` and `USER`. Conflicting with `actions`.<br/>    (Optional) `actions` - A set of IAM actions to grant or revoke permissions on. Maximum of 16 items. Conflicting with `role`. | <pre>list(object({<br/>    principal = string<br/>    role      = optional(string)<br/>    actions   = optional(set(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_ssl"></a> [ssl](#input\_ssl) | (Optional) A configuration for SSL (Secure Socket Layer) properties that apply when Amazon QuickSight connects to the data source. `ssl` as defined below.<br/>    (Optional) `enabled` - Whether to use SSL for the connection. Defaults to `true`. | <pre>object({<br/>    enabled = optional(bool, true)<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_connection"></a> [vpc\_connection](#input\_vpc\_connection) | (Optional) A configuration for VPC connection of the data source. `vpc_connection` as defined below.<br/>    (Optional) `enabled` - Whether to use a VPC connection for the data source. Defaults to `false`.<br/>    (Optional) `arn` - The Amazon Resource Name (ARN) for the VPC connection. | <pre>object({<br/>    enabled = optional(bool, false)<br/>    arn     = optional(string, null)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the QuickSight data source. |
| <a name="output_connection_string"></a> [connection\_string](#output\_connection\_string) | The connection string for the Aurora PostgreSQL database. |
| <a name="output_credentials"></a> [credentials](#output\_credentials) | The configuration for credentials used to connect to the data source. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the QuickSight data source. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the QuickSight data source. |
| <a name="output_name"></a> [name](#output\_name) | The identifier of the QuickSight data source. |
| <a name="output_parameters"></a> [parameters](#output\_parameters) | The configuration for parameters used to connect to the Aurora PostgreSQL data source. |
| <a name="output_permissions"></a> [permissions](#output\_permissions) | The permissions associated with the QuickSight data source. |
| <a name="output_ssl"></a> [ssl](#output\_ssl) | The configuration for SSL (Secure Socket Layer) properties of the data source. |
| <a name="output_type"></a> [type](#output\_type) | The type of the QuickSight data source. |
| <a name="output_vpc_connection"></a> [vpc\_connection](#output\_vpc\_connection) | The configuration for VPC connection of the data source. |
<!-- END_TF_DOCS -->
