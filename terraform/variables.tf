variable "project" {
  description = "Project prefix for resource names"
  type        = string
  default     = "coupon-platform"
}

variable "environment" {
  description = "dev or prod"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "single_nat" {
  description = "Use single NAT to save cost in dev. Set false in prod."
  type        = bool
  default     = true
}

variable "app_port" {
  type    = number
  default = 3000
}

variable "app_count" {
  description = "Desired ECS tasks"
  type        = number
  default     = 2
}

variable "app_cpu" {
  default = "256"
}

variable "app_memory" {
  default = "512"
}

variable "aurora_min_acu" {
  default = "0.5"
}

variable "aurora_max_acu" {
  default = "1.0"
}

variable "db_username" {
  type      = string
  default   = "coupon_admin"
  sensitive = true
}

variable "github_org" {
  description = "GitHub org/user for OIDC trust, e.g. AnkitTiwari643"
  type        = string
  default     = "AnkitTiwari643"
}

variable "github_repo" {
  description = "Repo name for OIDC trust"
  type        = string
  default     = "production-aws-platform"
}
