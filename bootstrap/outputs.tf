output "organization_token" {
  value = tfe_organization_token.cycas.token
  sensitive = true
}
