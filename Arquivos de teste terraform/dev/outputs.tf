output "api" {
  value = {
    resource_group       = module.api_core.resource_group
    container_registry   = module.api_core.container_registry
    container_app        = module.api_core.container_app
    url                  = module.api_core.api_url
    postgres_server      = module.api_core.postgres_server
    key_vault            = module.api_core.key_vault
    grader_container_app = module.api_core.grader_container_app
    grader_url           = module.api_core.grader_url
    grader_database      = module.api_core.grader_database
  }
}
