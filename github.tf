resource "random_string" "github_webhook_secret" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret" "github_webhook_secret" {
  #checkov:skip=CKV2_AWS_57:Ensure Secrets Manager secrets should have automatic rotation enabled
  #checkov:skip=CKV_AWS_149:Ensure that the KMS key used to encrypt the Secrets Manager secret is not publicly accessible
  name_prefix = "${local.name}-github-webhook-secret"
}

resource "aws_secretsmanager_secret_version" "github_webhook_secret" {
  secret_id     = aws_secretsmanager_secret.github_webhook_secret.id
  secret_string = random_string.github_webhook_secret.result
}

resource "github_repository_webhook" "main" {
  count = length(var.atlantis_github_repositories)

  repository = var.atlantis_github_repositories[count.index]

  configuration {
    url          = "https://${lower(local.name)}.${var.domain}/events"
    content_type = "application/json"
    insecure_ssl = false
    secret       = aws_secretsmanager_secret_version.github_webhook_secret.secret_string
  }

  events = [
    "issue_comment",
    "pull_request",
    "pull_request_review",
    "pull_request_review_comment",
  ]
}
