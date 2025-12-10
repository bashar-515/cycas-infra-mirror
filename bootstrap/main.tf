resource "tfe_organization" "cycas" {
  name = "Cycas"
  email = var.email
}

resource "tfe_organization_token" "cycas" {
  organization = tfe_organization.cycas.name
}
