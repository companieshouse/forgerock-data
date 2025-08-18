locals {
  common_tags = {
    Environment    = var.environment
    Service        = "ch-account"
    ServiceSubType = var.service_name
    Team           = "amido"
  }
  secrets           = data.vault_generic_secret.secrets.data
  inactive_file_url = base64decode(local.secrets.inactive_file_url_base64)
}
