resource "render_static_site" "main" {
    branch = "main"
    build_command = "npm run build"
    name = "cycas app"
    repo_url = "https://github.com/bashar-515/cycas-web"

    auto_deploy = true

    build_filter = {
      paths = [
        "src/**",
         "index.html",
         "package.json",
         "package-lock.json",
         "tsconfig.json",
      ]
    }

    custom_domains = [
      { name: "app.cycas.dev" },
    ]

    env_vars = {
      VITE_AUTHORITY = {
        value = "https://cycas-xr5tso.us1.zitadel.cloud"
      }
      VITE_CLIENT_ID = {
        value = "340202547190987480"
      }
      VITE_REDIRECT_URI = {
        value = "https://app.cycas.dev"
      }
      POST_LOGOUT_REDIRECT_URI = {
        value = "https://app.cycas.dev"
      }
    }

    publish_path = "dist"
}
