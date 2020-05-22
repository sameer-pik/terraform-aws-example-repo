variable "environment" {
  type        = "string"
  description = "The environment this stack belongs to"
}

variable "product_domain" {
  type        = "string"
  description = "The product domain this stack belongs to"
}

variable "service_name" {
  type        = "string"
  description = "Service name of this stack"
}

variable "team" {
  type        = "string"
  description = "Team name of this stack"
}

variable "role" {
  type        = "string"
  description = "role name for this stack"
}

variable "vpc_id" {
  type        = "string"
  description = "The ID of the VPC this stack belongs to"
}

variable "ec2_key_name" {
  type        = "string"
  description = "The name of the key for ec2 instances"
}

variable "lb_subnet_ids" {
  type        = "list"
  description = "The list of subnet ids to attach to the LB"
}

variable "data_subnet_id" {
  type        = "string"
  description = "The Database subnet id"
}

variable "app_subnet_id" {
  type        = "string"
  description = "The Application subnet id"
}
