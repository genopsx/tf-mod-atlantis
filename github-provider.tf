provider "github" {
  token = data.aws_secretsmanager_secret_version.github_token_secret_name.secret_string
  owner = var.github_org
}
