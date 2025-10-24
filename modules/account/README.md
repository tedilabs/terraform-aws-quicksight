# account

This module creates following resources.

- `aws_quicksight_account_subscription`
- `aws_quicksight_account_settings`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.17.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_quicksight_account_settings.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/quicksight_account_settings) | resource |
| [aws_quicksight_account_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/quicksight_account_subscription) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_edition"></a> [edition](#input\_edition) | (Required) The edition of QuickSight to use. Valid values are `STANDARD` and `ENTERPRISE`. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) A name for the QuickSight account settings. | `string` | n/a | yes |
| <a name="input_notification_email"></a> [notification\_email](#input\_notification\_email) | (Required) The email address to send notifications for the QuickSight account and subscription. | `string` | n/a | yes |
| <a name="input_active_directory"></a> [active\_directory](#input\_active\_directory) | (Optional) A configuration for Active Directory authentication. Only required for `ACTIVE_DIRECTORY` authentication method. `active_directory` as defined below.<br/>    (Required) `name` - The name of the Active Directory to associate with the QuickSight account.<br/>    (Required) `realm` - The realm for the Active Directory to associate with the QuickSight account.<br/>    (Required) `directory_id` - The Active Directory ID to associate with the QuickSight account. | <pre>object({<br/>    name         = string<br/>    realm        = string<br/>    directory_id = string<br/>  })</pre> | `null` | no |
| <a name="input_authentication_method"></a> [authentication\_method](#input\_authentication\_method) | (Optional) The authentication method for the QuickSight account. Valid values are `IAM_AND_QUICKSIGHT`, `IAM_ONLY`, `ACTIVE_DIRECTORY`, and `IAM_IDENTITY_CENTER`. | `string` | `"IAM_AND_QUICKSIGHT"` | no |
| <a name="input_default_namespace"></a> [default\_namespace](#input\_default\_namespace) | (Optional) The default namespace for the QuickSight account. Defaults to `default`. | `string` | `"default"` | no |
| <a name="input_iam_identity_center"></a> [iam\_identity\_center](#input\_iam\_identity\_center) | (Optional) A configuration for IAM Identity Center authentication. Only required for `IAM_IDENTITY_CENTER` authentication method. `iam_identity_center` as defined below.<br/>    (Required) `instance` - The ARN of the IAM Identity Center instance. | <pre>object({<br/>    instance = string<br/>  })</pre> | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region. | `string` | `null` | no |
| <a name="input_role_memberships"></a> [role\_memberships](#input\_role\_memberships) | (Optional) A configuration for initial role memberships in the QuickSight account. Only required for `ACTIVE_DIRECTORY` or `IAM_IDENTITY_CENTER` authentication methods. `role_memberships` as defined below.<br/>    (Required) `admin` - A set of group names for the admin role. Required for both `ACTIVE_DIRECTORY` and `IAM_IDENTITY_CENTER` authentication methods for initial setup.<br/>    (Optional) `admin_pro` - A set of group names for the admin pro role.<br/>    (Optional) `author` - A set of group names for the author role.<br/>    (Optional) `author_pro` - A set of group names for the author pro role.<br/>    (Optional) `reader` - A set of group names for the reader role.<br/>    (Optional) `reader_pro` - A set of group names for the reader pro role. | <pre>object({<br/>    admin      = set(string)<br/>    admin_pro  = optional(set(string), [])<br/>    author     = optional(set(string), [])<br/>    author_pro = optional(set(string), [])<br/>    reader     = optional(set(string), [])<br/>    reader_pro = optional(set(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_termination_protection_enabled"></a> [termination\_protection\_enabled](#input\_termination\_protection\_enabled) | (Optional) Whether termination protection is enabled for the QuickSight account. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional) How long to wait for the QuickSight account subscription to be created/deleted. | <pre>object({<br/>    create = optional(string, "10m")<br/>    delete = optional(string, "10m")<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_active_directory"></a> [active\_directory](#output\_active\_directory) | The configuration for Active Directory authentication. |
| <a name="output_authentication_method"></a> [authentication\_method](#output\_authentication\_method) | The authentication method for the QuickSight account. |
| <a name="output_default_namespace"></a> [default\_namespace](#output\_default\_namespace) | The default namespace for the QuickSight account. |
| <a name="output_edition"></a> [edition](#output\_edition) | The edition of QuickSight. |
| <a name="output_iam_identity_center"></a> [iam\_identity\_center](#output\_iam\_identity\_center) | The configuration for IAM Identity Center authentication. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the QuickSight account. |
| <a name="output_name"></a> [name](#output\_name) | The name of the QuickSight account. |
| <a name="output_notification_email"></a> [notification\_email](#output\_notification\_email) | The notification email for the QuickSight account. |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this module resources resides in. |
| <a name="output_role_memberships"></a> [role\_memberships](#output\_role\_memberships) | The role memberships for the QuickSight account. |
| <a name="output_status"></a> [status](#output\_status) | The subscription status of the QuickSight account. |
| <a name="output_termination_protection_enabled"></a> [termination\_protection\_enabled](#output\_termination\_protection\_enabled) | Whether termination protection is enabled for the QuickSight account. |
<!-- END_TF_DOCS -->
