# vpc-connection

This module creates following resources.

- `aws_quicksight_vpc_connection`
- `aws_quicksight_group_membership` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11 |
| <a name="requirement_assert"></a> [assert](#requirement\_assert) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.100 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_execution_role"></a> [execution\_role](#module\_execution\_role) | tedilabs/account/aws//modules/iam-role | ~> 0.31.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | tedilabs/network/aws//modules/security-group | ~> 0.32.0 |

## Resources

| Name | Type |
|------|------|
| [aws_quicksight_vpc_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/quicksight_vpc_connection) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | (Optional) The display name for the QuickSight VPC connection. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) An identifier for the QuickSight VPC connection. This ID is a unique identifier for each AWS Region in an AWS account. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Required) A list of subnet IDs to associate with the QuickSight VPC connection. At least two subnets are required. | `list(string)` | n/a | yes |
| <a name="input_default_execution_role"></a> [default\_execution\_role](#input\_default\_execution\_role) | (Optional) A configuration for the default execution role for the QuickSight VPC connection. Use `execution_role` if `default_execution_role.enabled` is `false`. `default_execution_role` as defined below.<br/>    (Optional) `enabled` - Whether to create the default execution role. Defaults to `true`.<br/>    (Optional) `name` - The name of the default execution role. Defaults to `quicksight-vpc-connection-${var.name}`.<br/>    (Optional) `path` - The path of the default execution role. Defaults to `/`.<br/>    (Optional) `description` - The description of the default execution role.<br/>    (Optional) `policies` - A list of IAM policy ARNs to attach to the default execution role. Defaults to `[]`.<br/>    (Optional) `inline_policies` - A Map of inline IAM policies to attach to the default execution role. (`name` => `policy`). | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string)<br/>    path        = optional(string, "/")<br/>    description = optional(string, "Managed by Terraform.")<br/><br/>    policies        = optional(list(string), [])<br/>    inline_policies = optional(map(string), {})<br/>  })</pre> | `{}` | no |
| <a name="input_default_security_group"></a> [default\_security\_group](#input\_default\_security\_group) | (Optional) The configuration of the default security group for the QuickSight VPC connection. `default_security_group` block as defined below.<br/>    (Optional) `enabled` - Whether to use the default security group. Defaults to `true`.<br/>    (Optional) `name` - The name of the default security group. If not provided, the QuickSight VPC connection ID is used for the name of security group.<br/>    (Optional) `description` - The description of the default security group. Defaults to `Managed by Terraform`.<br/>    (Optional) `ingress_rules` - A list of ingress rules in a security group. Defaults to `[]`. Each block of `ingress_rules` as defined below.<br/>      (Optional) `id` - The ID of the ingress rule. This value is only used internally within Terraform code.<br/>      (Optional) `description` - The description of the rule.<br/>      (Required) `protocol` - The protocol to match. Note that if `protocol` is set to `-1`, it translates to all protocols, all port ranges, and `from_port` and `to_port` values should not be defined.<br/>      (Required) `from_port` - The start of port range for the protocols.<br/>      (Required) `to_port` - The end of port range for the protocols.<br/>      (Optional) `ipv4_cidrs` - The IPv4 network ranges to allow, in CIDR notation.<br/>      (Optional) `ipv6_cidrs` - The IPv6 network ranges to allow, in CIDR notation.<br/>      (Optional) `prefix_lists` - The prefix list IDs to allow.<br/>      (Optional) `security_groups` - The source security group IDs to allow.<br/>      (Optional) `self` - Whether the security group itself will be added as a source to this ingress rule.<br/>    (Optional) `egress_rules` - A list of egress rules in a security group. Defaults to `[{ id = "default", protocol = -1, from_port = 1, to_port=65535, ipv4_cidrs = ["0.0.0.0/0"] }]`. Each block of `egress_rules` as defined below.<br/>      (Optional) `id` - The ID of the egress rule. This value is only used internally within Terraform code.<br/>      (Optional) `description` - The description of the rule.<br/>      (Required) `protocol` - The protocol to match. Note that if `protocol` is set to `-1`, it translates to all protocols, all port ranges, and `from_port` and `to_port` values should not be defined.<br/>      (Required) `from_port` - The start of port range for the protocols.<br/>      (Required) `to_port` - The end of port range for the protocols.<br/>      (Optional) `ipv4_cidrs` - The IPv4 network ranges to allow, in CIDR notation.<br/>      (Optional) `ipv6_cidrs` - The IPv6 network ranges to allow, in CIDR notation.<br/>      (Optional) `prefix_lists` - The prefix list IDs to allow.<br/>      (Optional) `security_groups` - The source security group IDs to allow.<br/>      (Optional) `self` - Whether the security group itself will be added as a source to this egress rule. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string)<br/>    description = optional(string, "Managed by Terraform.")<br/>    ingress_rules = optional(<br/>      list(object({<br/>        id              = optional(string)<br/>        description     = optional(string, "Managed by Terraform.")<br/>        protocol        = string<br/>        from_port       = number<br/>        to_port         = number<br/>        ipv4_cidrs      = optional(list(string), [])<br/>        ipv6_cidrs      = optional(list(string), [])<br/>        prefix_lists    = optional(list(string), [])<br/>        security_groups = optional(list(string), [])<br/>        self            = optional(bool, false)<br/>      })),<br/>      []<br/>    )<br/>    egress_rules = optional(<br/>      list(object({<br/>        id              = string<br/>        description     = optional(string, "Managed by Terraform.")<br/>        protocol        = string<br/>        from_port       = number<br/>        to_port         = number<br/>        ipv4_cidrs      = optional(list(string), [])<br/>        ipv6_cidrs      = optional(list(string), [])<br/>        prefix_lists    = optional(list(string), [])<br/>        security_groups = optional(list(string), [])<br/>        self            = optional(bool, false)<br/>      })),<br/>      [{<br/>        id          = "default"<br/>        description = "Allow all outbound traffic."<br/>        protocol    = "-1"<br/>        from_port   = 1<br/>        to_port     = 65535<br/>        ipv4_cidrs  = ["0.0.0.0/0"]<br/>      }]<br/>    )<br/>  })</pre> | `{}` | no |
| <a name="input_dns_resolvers"></a> [dns\_resolvers](#input\_dns\_resolvers) | (Optional) A list of IP addresses of DNS resolver endpoints for the QuickSight VPC connection. | `set(string)` | `[]` | no |
| <a name="input_execution_role"></a> [execution\_role](#input\_execution\_role) | (Optional) The ARN (Amazon Resource Name) of the IAM Role to associate with the QuickSight VPC connection. Only required if `default_execution_role.enabled` is `false`. | `string` | `null` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | (Optional) A list of security group IDs to associate with the QuickSight VPC connection. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional) How long to wait for the QuickSight VPC connection to be created/updated/deleted. | <pre>object({<br/>    create = optional(string, "5m")<br/>    update = optional(string, "5m")<br/>    delete = optional(string, "5m")<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the QuickSight VPC connection. |
| <a name="output_default_execution_role"></a> [default\_execution\_role](#output\_default\_execution\_role) | The configuration of the default execution role for the QuickSight VPC connection. |
| <a name="output_default_security_group"></a> [default\_security\_group](#output\_default\_security\_group) | The configuration of the default security group for the QuickSight VPC connection. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the QuickSight VPC connection. |
| <a name="output_dns_resolvers"></a> [dns\_resolvers](#output\_dns\_resolvers) | A list of IP addresses of DNS resolver endpoints for the QuickSight VPC connection. |
| <a name="output_execution_role"></a> [execution\_role](#output\_execution\_role) | The ID of execution role for the QuickSight VPC connection. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the QuickSight VPC connection. |
| <a name="output_name"></a> [name](#output\_name) | The identifier of the QuickSight VPC connection. |
| <a name="output_security_groups"></a> [security\_groups](#output\_security\_groups) | A list of security group IDs for the QuickSight VPC connection. |
| <a name="output_status"></a> [status](#output\_status) | The availability status of the QuickSight VPC connection. Valid values are `AVAILABLE`, `UNAVAILABLE` or `PARTIALLY_AVAILABLE`. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | A list of subnet IDs for the QuickSight VPC connection. |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | The VPC ID for the QuickSight VPC connection. |
<!-- END_TF_DOCS -->
