data "aws_iam_policy_document" "atlantis" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    resources = [
      "arn:aws:iam::*:role/DevOpsIaCRole",
    ]
  }
}

resource "aws_iam_policy" "main" {
  name        = "atlantis_allow_assume_deploy_role"
  description = "Policy for Atlantis to deploy to assume roles in other accounts"
  policy      = data.aws_iam_policy_document.atlantis.json
}

module "atlantis" {
  source  = "terraform-aws-modules/atlantis/aws"
  version = "4.4.0"

  name = local.name

  # ECS Container Definition
  atlantis = {
    image = var.container_image

    environment = [
      {
        name  = "ATLANTIS_GH_USER"
        value = var.github_user
      },
      {
        name  = "ATLANTIS_REPO_ALLOWLIST"
        value = var.atlantis_repo_allowlist
      },
      {
        name  = "ATLANTIS_REPO_CONFIG_JSON"
        value = jsonencode(yamldecode(file("${path.module}/${var.atlantis_repo_config_json}")))
      },
      {
        name  = "ATLANTIS_WRITE_GIT_CREDS"
        value = "true"
      },
      {
        name  = "ATLANTIS_TFE_LOCAL_EXECUTION_MODE"
        value = "true"
      },
      {
        name  = "ATLANTIS_DEFAULT_TF_VERSION"
        value = var.atlantis_default_tf_version
      },

    ]
    secrets = [
      {
        name      = "ATLANTIS_GH_TOKEN"
        valueFrom = data.aws_secretsmanager_secret_version.github_token_secret_name.arn
      },
      {
        name      = "ATLANTIS_GH_WEBHOOK_SECRET"
        valueFrom = aws_secretsmanager_secret_version.github_webhook_secret.arn
      },
      {
        name      = "ATLANTIS_TFE_TOKEN"
        valueFrom = data.aws_secretsmanager_secret_version.terraform_cloud_token_secret_name.arn
      },
    ]
  }

  # ALB
  alb_subnets     = var.alb_subnet_ids
  service_subnets = var.service_subnet_ids
  vpc_id          = var.vpc_id

  certificate_domain_name = "${lower(local.name)}.${var.domain}"
  route53_zone_id         = data.aws_route53_zone.this.id

  alb = {
    enable_deletion_protection = false
    security_group_ingress_rules = {
      all_https_github = {
        from_port      = 443
        to_port        = 443
        ip_protocol    = "tcp"
        description    = "HTTPS hooks from GitHub"
        prefix_list_id = var.prefix_list_id_github
      },
      all_https_devops = {
        from_port      = 443
        to_port        = 443
        ip_protocol    = "tcp"
        description    = "HTTPS access for DevOps"
        prefix_list_id = var.prefix_list_id_devops
      }
    }
    security_group_egress_rules = {
      all = {
        ip_protocol = "-1"
        cidr_ipv4   = "0.0.0.0/0"
      }
    }
  }

  service = {
    task_exec_secret_arns = [
      data.aws_secretsmanager_secret_version.terraform_cloud_token_secret_name.arn,
      data.aws_secretsmanager_secret_version.github_token_secret_name.arn,
      aws_secretsmanager_secret_version.github_webhook_secret.arn
    ]

    tasks_iam_role_name            = "AtlantisDevOps-${var.environment}"
    tasks_iam_role_use_name_prefix = false
    tasks_iam_role_policies = {
      DeployRole = aws_iam_policy.main.arn
    }
  }

  # EFS
  enable_efs = true
  efs = {
    mount_targets = {
      #tflint-ignore: terraform_deprecated_interpolation
      "${data.aws_subnet.service_0.availability_zone}" = {
        subnet_id = var.service_subnet_ids[0]
      }
      #tflint-ignore: terraform_deprecated_interpolation
      "${data.aws_subnet.service_1.availability_zone}" = {
        subnet_id = var.service_subnet_ids[1]
      }
      #tflint-ignore: terraform_deprecated_interpolation
      "${data.aws_subnet.service_2.availability_zone}" = {
        subnet_id = var.service_subnet_ids[2]
      }
    }
  }

  tags = local.tags
}

data "aws_subnet" "service_0" {
  id = var.service_subnet_ids[0]
}
data "aws_subnet" "service_1" {
  id = var.service_subnet_ids[1]
}
data "aws_subnet" "service_2" {
  id = var.service_subnet_ids[2]
}
