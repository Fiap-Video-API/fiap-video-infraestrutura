variable "cluster_name" {
  type = string
  default = "fiap-video-k8s"
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "zone_az1" {
  type = string
  default = "us-east-1a"
}

variable "zone_az2" {
  type = string
  default = "us-east-1b"
}

variable "iam_role_arn" {
  type = string
}

variable "url_load_balance_usuario" {
  type = string
}

variable "url_load_balance_video" {
  type = string
}