<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.58.0 |
| <a name="provider_github"></a> [github](#provider\_github) | 6.2.3 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_atlantis"></a> [atlantis](#module\_atlantis) | terraform-aws-modules/atlantis/aws | 4.4.0 |
| <a name="module_label"></a> [label](#module\_label) | git::git@github.com:genopsx/tf-mod-label.git | v2.0.1 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_secretsmanager_secret.github_webhook_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.github_webhook_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [github_repository_webhook.main](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository_webhook) | resource |
| [random_string.github_webhook_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_iam_policy_document.atlantis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_secretsmanager_secret_version.github_token_secret_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.terraform_cloud_token_secret_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_subnet.service_0](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.service_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.service_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accountable"></a> [accountable](#input\_accountable) | Email of rerson responsible for business and budget of the resource. | `string` | `"leigh.gawne@altium.com"` | no |
| <a name="input_alb_subnet_ids"></a> [alb\_subnet\_ids](#input\_alb\_subnet\_ids) | List of subnet IDs to run the ALB in | `list(string)` | n/a | yes |
| <a name="input_application"></a> [application](#input\_application) | Application is a software program that a user interacts with and performs a<br>wide range of operations. Some functionalities of an application can be<br>delivered as services.  If multiple applications use a resource, then use<br>shared. Other values than listed are allowed. | `string` | n/a | yes |
| <a name="input_atlantis_default_tf_version"></a> [atlantis\_default\_tf\_version](#input\_atlantis\_default\_tf\_version) | The version of Terraform to use with Atlantis | `string` | n/a | yes |
| <a name="input_atlantis_github_repositories"></a> [atlantis\_github\_repositories](#input\_atlantis\_github\_repositories) | List of repositories to enable Atlantis on.  Webhooks will be created for these repositories. | `list(string)` | `[]` | no |
| <a name="input_atlantis_repo_allowlist"></a> [atlantis\_repo\_allowlist](#input\_atlantis\_repo\_allowlist) | CSV delimited list of repos that Atlantis allows instruction from | `string` | n/a | yes |
| <a name="input_atlantis_repo_config_json"></a> [atlantis\_repo\_config\_json](#input\_atlantis\_repo\_config\_json) | The configuration to use for the Atlantis server side configuration | `string` | n/a | yes |
| <a name="input_backup"></a> [backup](#input\_backup) | Whether to enable AWS Backups for this item | `bool` | `false` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | The container image to run | `string` | n/a | yes |
| <a name="input_department"></a> [department](#input\_department) | Business entity within an organization that owns a resource.<br>Other values than listed are not allowed. | `string` | `"nexar"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | n/a | yes |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | n/a | `string` | n/a | yes |
| <a name="input_github_token_secret_name"></a> [github\_token\_secret\_name](#input\_github\_token\_secret\_name) | n/a | `string` | `"github-personal-access-token"` | no |
| <a name="input_github_user"></a> [github\_user](#input\_github\_user) | Who does the token belong to? | `string` | n/a | yes |
| <a name="input_operating_unit"></a> [operating\_unit](#input\_operating\_unit) | Business entity within an organization that owns a resource.<br>Other values than listed are not allowed.<br>Octopart is `search` for the `Search R&D` operating unit.<br>Nexar is `as` for the `Application Services R&D` operating unit. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Custom application name prefix | `string` | `null` | no |
| <a name="input_prefix_list_id_devops"></a> [prefix\_list\_id\_devops](#input\_prefix\_list\_id\_devops) | ID of the prefix list to allow to access the service from the DevOps team | `string` | n/a | yes |
| <a name="input_prefix_list_id_github"></a> [prefix\_list\_id\_github](#input\_prefix\_list\_id\_github) | ID of the prefix list to allow to access the service from GitHub | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `null` | no |
| <a name="input_responsible"></a> [responsible](#input\_responsible) | Email of technical person or a team responsible for the resource. | `string` | `"genopsx.devops@genopsx.com"` | no |
| <a name="input_service"></a> [service](#input\_service) | Service (or microservice) is not visible by a user directly. Usually services<br>are single task focused and are part of a bigger system.  If multiple services<br>use a resource, then use shared. Other values than listed are allowed. | `string` | n/a | yes |
| <a name="input_service_subnet_ids"></a> [service\_subnet\_ids](#input\_service\_subnet\_ids) | List of 3 subnet IDs to run the service in | `list(string)` | n/a | yes |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Custom application name suffix | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to add to all resources | `map(any)` | `{}` | no |
| <a name="input_terraform_cloud_token_secret_name"></a> [terraform\_cloud\_token\_secret\_name](#input\_terraform\_cloud\_token\_secret\_name) | n/a | `string` | `"terrform-cloud-token-for-atlantis"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC to run the service in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_url"></a> [url](#output\_url) | n/a |
<!-- END_TF_DOCS -->
