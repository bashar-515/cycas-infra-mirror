resource "render_static_site" "main" {
    branch = "main"
    build_command = "npm run build"
    name = "cycas app"
    repo_url = "https://github.com/bashar-515/cycas-app"

    auto_deploy = true

    build_filter = {
      paths = [
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
    }

    custom_domains = [
      { name: "app.cycas.dev" },
    ]

    env_vars = {
      VITE_OIDC_AUTHORITY = {
        value = "https://cycas-instance-rff81g.us1.zitadel.cloud"
      }
      VITE_OIDC_CLIENT_ID = {
        value = "353278728903597183"
      }
      VITE_OIDC_REDIRECT_URI = {
        value = "https://app.cycas.dev/callback"
      }
      VITE_OIDC_POST_LOGOUT_REDIRECT_URI = {
        value = "https://app.cycas.dev"
      }
      VITE_OIDC_USERINFO_ENDPOINT = {
        value = "https://cycas-instance-rff81g.us1.zitadel.cloud/oidc/v1/userinfo"
      }
    }

    publish_path = "dist"
}
