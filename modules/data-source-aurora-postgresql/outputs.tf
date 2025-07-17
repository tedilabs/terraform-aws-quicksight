output "id" {
  description = "The ID of the QuickSight data source."
  value       = aws_quicksight_data_source.this.data_source_id
}

output "arn" {
  description = "The ARN of the QuickSight data source."
  value       = aws_quicksight_data_source.this.arn
}

output "name" {
  description = "The identifier of the QuickSight data source."
  value       = aws_quicksight_data_source.this.data_source_id
}

output "display_name" {
  description = "The display name of the QuickSight data source."
  value       = aws_quicksight_data_source.this.name
}

output "type" {
  description = "The type of the QuickSight data source."
  value       = aws_quicksight_data_source.this.type
}

output "parameters" {
  description = "The configuration for parameters used to connect to the Aurora PostgreSQL data source."
  value = {
    database = aws_quicksight_data_source.this.parameters[0].aurora_postgresql[0].database
    host     = aws_quicksight_data_source.this.parameters[0].aurora_postgresql[0].host
    port     = aws_quicksight_data_source.this.parameters[0].aurora_postgresql[0].port
  }
}

output "credentials" {
  description = "The configuration for credentials used to connect to the data source."
  value = {
    type = nonsensitive(var.credentials.type)
    credential_pair = (nonsensitive(var.credentials.type) == "CREDENTIAL_PAIR"
      ? {
        username = nonsensitive(aws_quicksight_data_source.this.credentials[0].credential_pair[0].username)
      }
      : null
    )
    data_source            = nonsensitive(aws_quicksight_data_source.this.credentials[0].copy_source_arn)
    secrets_manager_secret = nonsensitive(aws_quicksight_data_source.this.credentials[0].secret_arn)
  }
}

output "vpc_connection" {
  description = <<EOF
  The configuration for VPC connection of the data source.
  EOF
  value = {
    enabled = var.vpc_connection.enabled
    arn     = one(aws_quicksight_data_source.this.vpc_connection_properties[*].vpc_connection_arn)
  }
}

output "ssl" {
  description = <<EOF
  The configuration for SSL (Secure Socket Layer) properties of the data source.
  EOF
  value = {
    enabled = !aws_quicksight_data_source.this.ssl_properties[0].disable_ssl
  }
}

output "connection_string" {
  description = "The connection string for the Aurora PostgreSQL database."
  value       = "${var.parameters.host}:${var.parameters.port}/${var.parameters.database}"
}

# output "debug" {
#   value = {
#     for k, v in aws_quicksight_data_source.this :
#     k => v
#     if !contains(["aws_account_id", "arn", "id", "name", "data_source_id", "tags", "tags_all", "type", "vpc_connection_properties", "ssl_properties", "parameters", "credentials"], k)
#   }
# }
