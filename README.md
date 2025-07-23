# terraform-aws-quicksight

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/tedilabs/terraform-aws-quicksight?color=blue&sort=semver&style=flat-square)
![GitHub](https://img.shields.io/github/license/tedilabs/terraform-aws-quicksight?color=blue&style=flat-square)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=flat-square)](https://github.com/pre-commit/pre-commit)

Terraform module which creates data related resources on AWS.

- [account](./modules/account)
- [data-source](./modules/data-source)
- [folder](./modules/folder)
- [group](./modules/group)
- [namespace](./modules/namespace)
- [user](./modules/user)
- [vpc-connection](./modules/vpc-connection)


## Target AWS Services

Terraform Modules from [this package](https://github.com/tedilabs/terraform-aws-quicksight) were written to manage the following AWS Services with Terraform.

- **AWS QuickSight**
  - Account
    - Subscription
    - Settings
  - Data Sources
    - AWS Athena
    - AWS S3
    - Aurora MySQL
    - Aurora PostgreSQL
    - MariaDB
    - MySQL
    - Oracle
    - PostgreSQL
    - SQL Server
  - Folder
  - User & Group
  - Namespace
  - VPC Connection


## Examples

### QuickSight

- [QuickSight User and Group](./examples/quicksight-user-and-group)
- [QuickSight Assets](./examples/quicksight-assets)


## Self Promotion

Like this project? Follow the repository on [GitHub](https://github.com/tedilabs/terraform-aws-quicksight). And if you're feeling especially charitable, follow **[posquit0](https://github.com/posquit0)** on GitHub.


## License

Provided under the terms of the [Apache License](LICENSE).

Copyright © 2022-2025, [Byungjin Park](https://www.posquit0.com).
