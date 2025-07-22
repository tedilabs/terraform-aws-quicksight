# user

This module creates following resources.

- `aws_quicksight_user` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.100 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_quicksight_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/quicksight_user) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_quicksight_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/quicksight_user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) A name for the QuickSight user. | `string` | n/a | yes |
| <a name="input_email"></a> [email](#input\_email) | (Optional) The email address of the user that you want to register. Only required for `INTERNAL` type users. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) The namespace that you want the user to be a part of. | `string` | `"default"` | no |
| <a name="input_role"></a> [role](#input\_role) | (Optional) The Amazon QuickSight role for the user. Valid values are `ADMIN`, `ADMIN_PRO`, `AUTHOR`, `AUTHOR_PRO`, `READER` and `READER_PRO`. Only required for `INTERNAL` type users. Defaults to `READER`. | `string` | `"READER"` | no |
| <a name="input_type"></a> [type](#input\_type) | (Optional) The type of the QuickSight user. Valid values are `INTERNAL` and `EXTERNAL`. Defaults to `INTERNAL`. `EXTERNAL` for the Active Directory or IAM Identity Center authentication method. | `string` | `"INTERNAL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the QuickSight user. |
| <a name="output_email"></a> [email](#output\_email) | The email address of the user. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the QuickSight user. |
| <a name="output_identity_type"></a> [identity\_type](#output\_identity\_type) | The identity type for the user. |
| <a name="output_is_active"></a> [is\_active](#output\_is\_active) | Whether the user is active or not. |
| <a name="output_name"></a> [name](#output\_name) | The name of the QuickSight user. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace that the user belongs to. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the user. |
| <a name="output_role"></a> [role](#output\_role) | The Amazon QuickSight role for the user. |
| <a name="output_type"></a> [type](#output\_type) | The type of the QuickSight user. |
<!-- END_TF_DOCS -->