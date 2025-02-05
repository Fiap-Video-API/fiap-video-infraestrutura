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

variable "allocated_storage" {
  description = "Espaço de armazenamento alocado para o banco de dados (em GB)."
  default     = 20
}

variable "engine" {
  description = "O mecanismo de banco de dados a ser usado (ex: 'mysql', 'postgres')."
  default     = "mysql"
}

variable "engine_version" {
  description = "A versão do mecanismo de banco de dados."
  default     = "8.0.35"
}

variable "instance_class" {
  description = "Tipo de instância do banco de dados."
  default     = "db.t3.micro"
}

variable "parameter_group" {
  description = "Nome do grupo de parâmetros do DB."
  default     = "default.mysql8.0"
}