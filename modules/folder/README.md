# folder

This module creates following resources.

- `aws_quicksight_folder`
- `aws_quicksight_folder_membership` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.18.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |

## Resources

| Name | Type |
|------|------|
| [aws_quicksight_folder.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/quicksight_folder) | resource |
| [aws_quicksight_folder_membership.analysis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/quicksight_folder_membership) | resource |
| [aws_quicksight_folder_membership.dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/quicksight_folder_membership) | resource |
| [aws_quicksight_folder_membership.dataset](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/quicksight_folder_membership) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) An identifier for the QuickSight folder. | `string` | n/a | yes |
| <a name="input_assets"></a> [assets](#input\_assets) | (Optional) A configuration for assets of this QuickSight folder. `assets` as defined below.<br/>    (Optional) `analyses` - A list of the IDs of the analysis assets to add to this QuickSight folder.<br/>    (Optional) `dashboards` - A list of the IDs of the dashboard assets to add to this QuickSight folder.<br/>    (Optional) `datasets` - A list of the IDs of the dataset assets to add to this QuickSight folder. | <pre>object({<br/>    analyses   = optional(list(string), [])<br/>    dashboards = optional(list(string), [])<br/>    datasets   = optional(list(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | (Optional) A display name for the QuickSight folder. | `string` | `""` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_parent_folder"></a> [parent\_folder](#input\_parent\_folder) | (Optional) The Amazon Resource Name (ARN) for the parent folder. If not set, creates a root-level folder. | `string` | `null` | no |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | (Optional) A list of resource permissions on the QuickSight folder. Maximum of 64 items. Each value of `permissions` as defined below.<br/>    (Required) `principal` - The Amazon Resource Name (ARN) of the principal. This can be one of the following:<br/>      - The ARN of an Amazon QuickSight user or group associated with a data source or dataset. (This is common.)<br/>      - The ARN of an Amazon QuickSight user, group, or namespace associated with an analysis, dashboard, template, or theme. (This is common.)<br/>      - The ARN of an Amazon Web Services account root: This is an IAM ARN rather than a QuickSight ARN. Use this option only to share resources (templates) across Amazon Web Services accounts. (This is less common.)<br/>    (Optional) `role` - A role of principal with a pre-defined set of permissions. Valid values are `OWNER` and `READER`. Conflicting with `actions`.<br/>    (Optional) `actions` - A set of IAM actions to grant or revoke permissions on. Conflicting with `role`. | <pre>list(object({<br/>    principal = string<br/>    role      = optional(string)<br/>    actions   = optional(set(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional) How long to wait for the QuickSight Folder to be created/read/updated/deleted. | <pre>object({<br/>    create = optional(string, "5m")<br/>    read   = optional(string, "5m")<br/>    update = optional(string, "5m")<br/>    delete = optional(string, "5m")<br/>  })</pre> | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | (Optional) The type of the QuickSight folder. Valid values are `RESTRICTED`, `SHARED`. Defaults to `SHARED`. | `string` | `"SHARED"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the QuickSight folder. |
| <a name="output_assets"></a> [assets](#output\_assets) | A configuration for assets of this QuickSight folder.<br/>    `analyses` - A list of the IDs of the analysis assets of this QuickSight folder.<br/>    `dashboards` - A list of the IDs of the dashboard assets of this QuickSight folder.<br/>    `datasets` - A list of the IDs of the dataset assets of this QuickSight folder. |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The time that the QuickSight folder was created. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the QuickSight folder. |
| <a name="output_hierarchy"></a> [hierarchy](#output\_hierarchy) | The hierarchy of the QuickSight folder. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the QuickSight folder. |
| <a name="output_name"></a> [name](#output\_name) | The name of the QuickSight folder. |
| <a name="output_permissions"></a> [permissions](#output\_permissions) | A list of resource permissions on the QuickSight folder. |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this module resources resides in. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_type"></a> [type](#output\_type) | The type of the QuickSight folder. |
| <a name="output_updated_at"></a> [updated\_at](#output\_updated\_at) | The time that the QuickSight folder was last updated. |
<!-- END_TF_DOCS -->
