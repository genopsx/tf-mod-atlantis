locals {
  name = "${var.application}-${var.github_org}-${var.environment}"

  tags = merge(
    module.label.tags,
    var.tags,
    {
      Name = lower(local.name)
    }
  )
}
