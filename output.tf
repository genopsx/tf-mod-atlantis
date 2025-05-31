output "url" {
  value = "https://${lower(local.name)}.${var.domain}"
}
