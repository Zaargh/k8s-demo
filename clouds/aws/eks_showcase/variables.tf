variable "name_prefix" {
  type = string
}

variable "eks_cluster_version" {
  type = string
}

variable "eks_create_kms_key" {
  type    = bool
  default = true
}

variable "public_key_file" {
  type = string
}

variable "enable_cluster_creator_admin_permissions" {
  type    = bool
  default = false
}

variable "load_balancer_controller_version" {
  type = string
}

variable "alb_ingress_tag" {
  type = string
}
