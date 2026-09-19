variable "location" {
  type    = string
  default = "eastus"
}
variable "postgres_location" {
  type    = string
  default = "northcentralus"
}
variable "unique_suffix" {
  type    = string
  default = "9e0045"
}
variable "github_client_id" {
  type = string
}
variable "github_client_secret" {
  type      = string
  sensitive = true
}
