data "aws_route53_zone" "this" {
  name = var.domain
}

data "aws_secretsmanager_secret_version" "github_token_secret_name" {
  secret_id = var.github_token_secret_name
}

data "aws_secretsmanager_secret_version" "terraform_cloud_token_secret_name" {
  secret_id = var.terraform_cloud_token_secret_name
}
