terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = ">= 0.5.8"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.15.0"
    }
  }
}

provider "databricks" {
  alias = "dev"
}

provider "databricks" {
  alias = "staging"
}

provider "databricks" {
  alias = "prod"
}

provider "azuread" {}

module "mlops_azure_infrastructure_with_sp_creation" {
  source = "../."
  providers = {
    databricks.dev     = databricks.dev
    databricks.staging = databricks.staging
    databricks.prod    = databricks.prod
    azuread            = azuread
  }
  staging_workspace_id          = "123456789"
  prod_workspace_id             = "987654321"
  azure_tenant_id               = "a1b2c3d4-e5f6-g7h8-i9j0-k9l8m7n6o5p4"
  additional_token_usage_groups = ["users"] # This field is optional.
}
