# data-source

This module creates following resources.

- `aws_quicksight_data_source`

## Supported Data Source Types

This module supports the following QuickSight data source types:

### Database Types
- **AURORA_POSTGRESQL** - Amazon Aurora PostgreSQL
- **AURORA** - Amazon Aurora MySQL
- **MYSQL** - MySQL
- **ORACLE** - Oracle Database
- **POSTGRESQL** - PostgreSQL
- **SQLSERVER** - Microsoft SQL Server
- **MARIADB** - MariaDB

### Other Types
- **ATHENA** - Amazon Athena
- **S3** - Amazon S3

## Parameter Schemas by Data Source Type

### Database Types (AURORA_POSTGRESQL, AURORA, MYSQL, ORACLE, POSTGRESQL, SQLSERVER, MARIADB)

```hcl
parameters = {
  database = "your_database_name"     # Required
  host     = "your_database_host"     # Required
  port     = 5432                     # Optional, defaults vary by type
}
```

**Default Ports:**
- AURORA_POSTGRESQL, POSTGRESQL: 5432
- AURORA, MYSQL, MARIADB: 3306
- ORACLE: 1521
- SQLSERVER: 1433

### ATHENA

```hcl
parameters = {
  work_group = "primary"              # Optional, defaults to "primary"
}
```

### S3

```hcl
parameters = {
  manifest_file_location = "s3://bucket/path/to/manifest.json"  # Required
  iam_role               = "arn:aws:iam::123456789012:role/quicksight-s3-role"  # Optional, but recommended
}
```

**Best Practice**: Use an IAM role for S3 access instead of embedded credentials for better security.

## Examples

### Aurora PostgreSQL Data Source

```hcl
module "aurora_postgresql_data_source" {
  source = "tedilabs/quicksight/aws//modules/data-source"

  name         = "aurora-postgresql-ds"
  display_name = "Aurora PostgreSQL Data Source"
  type         = "AURORA_POSTGRESQL"

  parameters = {
    database = "mydb"
    host     = "aurora-cluster.cluster-abc123.us-east-1.rds.amazonaws.com"
    port     = 5432
  }

  credentials = {
    type                   = "SECRETS_MANAGER"
    secrets_manager_secret = "arn:aws:secretsmanager:us-east-1:123456789012:secret:aurora-secret"
  }
}
```

### Athena Data Source

```hcl
module "athena_data_source" {
  source = "tedilabs/quicksight/aws//modules/data-source"

  name         = "athena-ds"
  display_name = "Athena Data Source"
  type         = "ATHENA"

  parameters = {
    work_group = "analytics-workgroup"
  }

  # Athena typically doesn't require credentials
  credentials = null
}
```

### S3 Data Source

```hcl
module "s3_data_source" {
  source = "tedilabs/quicksight/aws//modules/data-source"

  name         = "s3-ds"
  display_name = "S3 Data Source"
  type         = "S3"

  parameters = {
    manifest_file_location = "s3://my-bucket/data/manifest.json"
    iam_role               = "arn:aws:iam::123456789012:role/quicksight-s3-access-role"
  }

  # S3 data sources typically don't require credentials when using IAM roles
  credentials = null
}
```

#### IAM Role Requirements for S3

The IAM role specified in `iam_role` should have:

1. **Trust policy** allowing QuickSight to assume the role:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "quicksight.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

2. **Permissions policy** for S3 access:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::my-bucket",
        "arn:aws:s3:::my-bucket/*"
      ]
    }
  ]
}
```

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
| [aws_quicksight_data_source.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/quicksight_data_source) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) An identifier for the QuickSight data source. This ID is a unique identifier for each AWS Region in an AWS account. | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | (Required) A configuration for parameters used to connect to the data source. The structure varies based on the data source type:<br/><br/>  **AURORA\_POSTGRESQL/AURORA/MYSQL/ORACLE/POSTGRESQL/SQLSERVER/MARIADB:**<br/>    (Required) `database` - The name of the database to connect to.<br/>    (Required) `host` - The hostname of the database server.<br/>    (Optional) `port` - The port number for the database server. Defaults vary by type.<br/><br/>  **ATHENA:**<br/>    (Optional) `workgroup` - The name of the Athena workgroup. Defaults to `primary`.<br/><br/>  **S3:**<br/>    (Required) `manifest_file_location` - The Amazon S3 location of the manifest file in the format `s3://bucket/key`.<br/>    (Optional) `iam_role` - The IAM role ARN that QuickSight uses to access the S3 bucket instead of an account-wide IAM role. Recommended for security best practices. | `any` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | (Required) The type of the QuickSight data source. Valid values are `AURORA_POSTGRESQL`, `AURORA`, `ATHENA`, `MYSQL`, `ORACLE`, `POSTGRESQL`, `S3`, `SQLSERVER`, `MARIADB`. | `string` | n/a | yes |
| <a name="input_credentials"></a> [credentials](#input\_credentials) | (Optional) A configuration for credentials which Amazon QuickSight uses to connect to the data source. Not required for S3 data sources. `credentials` as defined below.<br/>    (Optional) `type` - The type of credentials to use. Valid values are `CREDENTIAL_PAIR`, `COPY_DATA_SOURCE`, or `SECRETS_MANAGER`. Defaults to `SECRETS_MANAGER`.<br/>    (Optional) `credential_pair` - Credential pair with `username` and `password`.<br/>    (Optional) `data_source` - The ARN of a data source that has the credential pair to use.<br/>    (Optional) `secrets_manager_secret` - The ARN of the secret in AWS Secrets Manager containing the credentials. | <pre>object({<br/>    type = optional(string, "SECRETS_MANAGER")<br/>    credential_pair = optional(object({<br/>      username = string<br/>      password = string<br/>    }))<br/>    data_source            = optional(string)<br/>    secrets_manager_secret = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | (Optional) The display name for the QuickSight data source, maximum of 128 characters. | `string` | `""` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | (Optional) A list of resource permissions on the data source. Maximum of 64 items. Each item of `permissions` as defined below.<br/>    (Required) `principal` - The Amazon Resource Name (ARN) of the principal. This can be one of the following:<br/>      - The ARN of an Amazon QuickSight user or group associated with a data source or dataset. (This is common.)<br/>      - The ARN of an Amazon QuickSight user, group, or namespace associated with an analysis, dashboard, template, or theme. (This is common.)<br/>      - The ARN of an Amazon Web Services account root: This is an IAM ARN rather than a QuickSight ARN. Use this option only to share resources (templates) across Amazon Web Services accounts. (This is less common.)<br/>    (Optional) `role` - A role of principal with a pre-defined set of permissions. Valid values are `OWNER` and `USER`. Conflicting with `actions`.<br/>    (Optional) `actions` - A set of IAM actions to grant or revoke permissions on. Maximum of 16 items. Conflicting with `role`. | <pre>list(object({<br/>    principal = string<br/>    role      = optional(string)<br/>    actions   = optional(set(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_ssl"></a> [ssl](#input\_ssl) | (Optional) A configuration for SSL (Secure Socket Layer) properties that apply when Amazon QuickSight connects to the data source. `ssl` as defined below.<br/>    (Optional) `enabled` - Whether to use SSL for the connection. Defaults to `true`. | <pre>object({<br/>    enabled = optional(bool, true)<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_connection"></a> [vpc\_connection](#input\_vpc\_connection) | (Optional) A configuration for VPC connection of the data source. `vpc_connection` as defined below.<br/>    (Optional) `enabled` - Whether to use a VPC connection for the data source. Defaults to `false`.<br/>    (Optional) `arn` - The Amazon Resource Name (ARN) for the VPC connection. | <pre>object({<br/>    enabled = optional(bool, false)<br/>    arn     = optional(string, null)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the QuickSight data source. |
| <a name="output_connection_string"></a> [connection\_string](#output\_connection\_string) | The connection string for the database (when applicable). |
| <a name="output_credentials"></a> [credentials](#output\_credentials) | The configuration for credentials used to connect to the data source. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the QuickSight data source. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the QuickSight data source. |
| <a name="output_name"></a> [name](#output\_name) | The identifier of the QuickSight data source. |
| <a name="output_parameters"></a> [parameters](#output\_parameters) | The configuration for parameters used to connect to the data source. |
| <a name="output_permissions"></a> [permissions](#output\_permissions) | The permissions associated with the QuickSight data source. |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this module resources resides in. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_ssl"></a> [ssl](#output\_ssl) | The configuration for SSL (Secure Socket Layer) properties of the data source. |
| <a name="output_type"></a> [type](#output\_type) | The type of the QuickSight data source. |
| <a name="output_vpc_connection"></a> [vpc\_connection](#output\_vpc\_connection) | The configuration for VPC connection of the data source. |
<!-- END_TF_DOCS -->
