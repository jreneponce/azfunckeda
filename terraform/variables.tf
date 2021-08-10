variable "project" {
  type        = string
  default     = ""
  description = "Project name"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment"
}

variable "location" {
  type        = string
  default     = ""
  description = "Azure region"
}

variable "subscription_id" {
  type = string
  default = ""
  description = "Az Subscription Id"
}
