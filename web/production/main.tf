resource "cloudflare_pages_project" "main" {
    account_id = var.account_id
    name = var.project_name
    production_branch = "main"

    build_config = {
      build_command = "npm run build"
      destination_dir = "dist"
    }

    deployment_configs = {
      production = {
        fail_open = false

        env_vars = {
          VITE_OIDC_AUTHORITY = {
            type = "plain_text"
            value = ""
          }
          VITE_OIDC_CLIENT_ID = {
            type = "plain_text"
            value = ""
          }
          VITE_OIDC_REDIRECT_URI = {
            type = "plain_text"
            value = ""
          }
          VITE_OIDC_POST_LOGOUT_REDIRECT_URI = {
            type = "plain_text"
            value = ""
          }
          VITE_OIDC_USERINFO_ENDPOINT = {
            type = "plain_text"
            value = ""
          }
        }
      }

      preview = {
        fail_open = false
      }
    }

    source = {
      type = "github"

      config = {
        owner = "bashar-515"

        path_includes = [
          "web/**",
          "index.html",
          "package.json",
          "package-lock.json",
          "svelte.config.js",
          "tsconfig.app.json",
          "tsconfig.json",
          "tsconfig.node.json",
          "vite.config.ts",
        ]

        production_branch = "main"
        production_deployments_enabled = true
        repo_name = "cycas-app"
      }
    }
}

locals {
  app_subdomain = "app"
  app_domain_name = "${local.app_subdomain}.${var.domain_name}"
}

resource "cloudflare_pages_domain" "main" {
  account_id = var.account_id
  name = local.app_domain_name
  project_name = cloudflare_pages_project.main.name
}

data "cloudflare_zone" "main" {
  filter = {
    name = var.domain_name
  }
}

locals {
  ttl = 1
  type = "CNAME"
  proxied = true
}

resource "cloudflare_dns_record" "app" {
    name = local.app_subdomain
    ttl = local.ttl
    type = local.type
    zone_id = data.cloudflare_zone.main.id
    content = cloudflare_pages_project.main.subdomain

    proxied = local.proxied
}
