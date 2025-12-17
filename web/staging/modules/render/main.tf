resource "render_static_site" "main" {
    branch = "main"
    build_command = "npm run build"
    name = "cycas web app"
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

    publish_path = "dist"
}
