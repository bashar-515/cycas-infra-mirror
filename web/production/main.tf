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
          VITE_AUTHORITY = {
            type = "plain_text"
            value = "https://cycas-xr5tso.us1.zitadel.cloud"
          }
          VITE_CLIENT_ID = {
            type = "plain_text"
            value = "340202806600350793"
          }
          VITE_REDIRECT_URI = {
            type = "plain_text"
            value = "https://app.cycas.me"
          }
          POST_LOGOUT_REDIRECT_URI = {
            type = "plain_text"
            value = "https://app.cycas.me"
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
          "src/**",
         "index.html",
         "package.json",
         "package-lock.json",
         "tsconfig.json",
        ]

        production_branch = "main"
        production_deployments_enabled = true
        repo_name = "cycas-web"
      }
    }
}

resource "cloudflare_pages_domain" "main" {
  account_id = var.account_id
  name = var.domain_name
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
    name = "app"
    ttl = local.ttl
    type = local.type
    zone_id = data.cloudflare_zone.main.id
    content = cloudflare_pages_project.main.subdomain

    proxied = local.proxied
}
