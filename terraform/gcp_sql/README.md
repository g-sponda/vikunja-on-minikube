# Terraform Google Cloud SQL Setup

This Terraform configuration deploys a Google Cloud SQL instance running PostgreSQL. It includes:

- A PostgreSQL Cloud SQL instance
- A database within the instance
- A database user with a randomly generated password

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) v1.9+
- Google Cloud SDK installed and authenticated (`gcloud auth application-default login`)
- Access to a Google Cloud project

## Files Structure

```
.
├── environments/
│   └── stg.tfvars          # Environment-specific variables (staging)
├── locals.tf               # Local values for configuration
├── main.tf                 # Main Terraform resources
├── providers.tf            # Provider configuration
├── variables.tf            # Input variable definitions
└── versions.tf             # Terraform version and provider constraints
```

## Configuration

### Variables

| Variable          | Description                                    | Example Value         |
| ----------------- | ---------------------------------------------- | --------------------- |
| `project`         | The Google Cloud project ID                    | `my-gcp-project`      |
| `region`          | The region to deploy the Cloud SQL instance    | `europe-west3`        |
| `database_config` | Configuration object for the database instance | (See structure below) |

### `database_config` Structure

```hcl
{
  instance = {
    name          = "my-database-instance"    # Cloud SQL instance name
    version       = "POSTGRES_15"             # PostgreSQL version
    database_tier = "db-f1-micro"             # Machine tier (e.g., db-f1-micro)
  }
  db_user = "root"                             # Database username
  db_name = "mydatabase"                       # Database name
}
```

## Usage

1. **Initialize Terraform**

```bash
terraform init
```

2. **Validate Configuration**

```bash
terraform validate
```

3. **Plan the Infrastructure**

```bash
terraform plan -var-file=environments/stg.tfvars
```

4. **Apply the Infrastructure**

```bash
terraform apply -var-file=environments/stg.tfvars
```

5. **Destroy the Infrastructure (if needed)**

```bash
terraform destroy -var-file=environments/stg.tfvars
```

## Outputs

- PostgreSQL user password (generated randomly)

### Retrieve the Password

After applying the infrastructure, you can retrieve the randomly generated PostgreSQL user password using the following command:

```bash
terraform output -raw postgres_password
```

If you did not define an output for the password, you can also inspect the Terraform state directly:

```bash
terraform state show random_string.postgres_password
```

## Notes

- Ensure that the Google Cloud project has Cloud SQL Admin permissions.
- The PostgreSQL user password is randomly generated and can be retrieved via the Terraform state.

## Troubleshooting

- Ensure that the Google Cloud API `sqladmin.googleapis.com` is enabled.
- Confirm that your IAM role has the necessary permissions to create SQL instances.
