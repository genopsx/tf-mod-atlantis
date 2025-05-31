variable "domain" {
  type = string
}

variable "terraform_cloud_token_secret_name" {
  default = "terrform-cloud-token-for-atlantis"
  type    = string
}

variable "github_token_secret_name" {
  default = "github-personal-access-token"
  type    = string
}

variable "github_org" {
  type = string
}

variable "github_user" {
  type        = string
  description = "Who does the token belong to?"
}

variable "atlantis_repo_allowlist" {
  type        = string
  description = "CSV delimited list of repos that Atlantis allows instruction from"
}

variable "atlantis_github_repositories" {
  type        = list(string)
  description = "List of repositories to enable Atlantis on.  Webhooks will be created for these repositories."
  default     = []
}

variable "atlantis_repo_config_json" {
  type        = string
  description = "The configuration to use for the Atlantis server side configuration"
}

variable "atlantis_default_tf_version" {
  type        = string
  description = "The version of Terraform to use with Atlantis"
}

variable "prefix_list_id_github" {
  type        = string
  description = "ID of the prefix list to allow to access the service from GitHub"
}

variable "prefix_list_id_devops" {
  type        = string
  description = "ID of the prefix list to allow to access the service from the DevOps team"

}

variable "service_subnet_ids" {
  type        = list(string)
  description = "List of 3 subnet IDs to run the service in"

  validation {
    condition     = length(var.service_subnet_ids) == 3
    error_message = "You must provide 3 subnet IDs for the service."
  }
}

variable "alb_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to run the ALB in"

  validation {
    condition     = length(var.alb_subnet_ids) == 3
    error_message = "You must provide 3 subnet IDs for the ALBs."
  }
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to run the service in"
}

variable "container_image" {
  type        = string
  description = "The container image to run"
}
