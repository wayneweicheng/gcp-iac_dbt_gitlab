# GCP Infrastructure as Code with DBT Integration

A comprehensive infrastructure as code (IaC) solution that provisions and manages Google Cloud Platform (GCP) resources using Terraform, and implements data transformation workflows using DBT (Data Build Tool).

## Project Overview

This project automates the deployment of data infrastructure on Google Cloud Platform using:
- **Terraform** for infrastructure provisioning
- **DBT** for data transformation
- **Jenkins** for CI/CD pipeline automation

## Infrastructure Components

### GCP Resources
- BigQuery datasets and tables
- Google Cloud Storage buckets
- IAM configurations

### Data Transformation
- DBT models for transforming data in BigQuery
- Sample transformation models included

## Project Structure

```
.
├── terraform/              # Terraform configuration files
│   ├── backend.tf          # State backend configuration
│   ├── big_query.tf        # BigQuery resources
│   ├── gcs.tf              # GCS bucket definitions
│   ├── main.tf             # Main Terraform configuration
│   ├── provider.tf         # GCP provider configuration
│   └── terraform.tfvars    # Terraform variables
│
├── dbt/                    # DBT projects
│   ├── dbt_sample_bigquery/# Sample DBT project for BigQuery
│   │   ├── models/         # DBT transformation models
│   │   ├── macros/         # Reusable SQL snippets
│   │   ├── tests/          # Data tests
│   │   ├── dbt_project.yml # DBT project configuration
│   │   └── ...             # Other DBT components
│   └── requirements.txt    # Python dependencies for DBT
│
├── Jenkinsfile             # CI/CD pipeline definition
└── creds/                  # Credentials directory (git-ignored)
```

## CI/CD Pipeline

The Jenkinsfile defines a pipeline that:
1. Validates Terraform configuration
2. Plans Terraform changes
3. Applies Terraform changes to create/update GCP resources
4. Runs DBT scripts to transform data in BigQuery

## Getting Started

### Prerequisites
- Google Cloud Platform account and project
- GCP Service Account with appropriate permissions
- Terraform installed (or use the Docker image as in the Jenkinsfile)
- DBT installed (or use the Docker image as in the Jenkinsfile)
- Jenkins server (optional, for CI/CD)

### Setup Instructions

1. Clone the repository:
   ```
   git clone <repository-url>
   cd gcp-iac
   ```

2. Configure GCP credentials:
   - Create a service account JSON key
   - Place it in the `creds/` directory (or use environment variables)

3. Initialize Terraform:
   ```
   cd terraform
   terraform init
   ```

4. Apply Terraform configuration:
   ```
   terraform plan -out planfile
   terraform apply planfile
   ```

5. Run DBT models:
   ```
   cd ../dbt
   python -m venv venv_dbt
   source venv_dbt/bin/activate
   pip install -r requirements.txt
   cd dbt_sample_bigquery
   dbt run
   ```

## Environment Variables

- `SERVICE_ACCOUNT`: GCP service account JSON (Base64 encoded)
- `GCP_PROJECT_ID`: Google Cloud Project ID
- `TF_VAR_branch`: Environment branch (e.g., dev, prod)
- `TF_VAR_suffix`: Resource name suffix for uniqueness

## Contributing

For contributions, please follow the standard Git workflow:
1. Create a feature branch
2. Make your changes
3. Submit a merge request

## License

[Specify your license here]
