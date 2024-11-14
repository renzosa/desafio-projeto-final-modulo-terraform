variable "main_vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "zone_a" {
  description = "Availability Zone A"
  type        = string
  default     = "us-east-1a"
}
variable "zone_b" {
  description = "Availability Zone B"
  type        = string
  default     = "us-east-1b"
}
variable "zone_c" {
  description = "Availability Zone C"
  type        = string
  default     = "us-east-1c"
}

variable "public_a_subnet_cidr" {
  description = "CIDR Subnet Publica A"
  type        = string
  default     = "10.0.1.0/16"
}
variable "public_b_subnet_cidr" {
  description = "CIDR Subnet Publica B"
  type        = string
  default     = "10.0.2.0/16"
}
variable "public_c_subnet_cidr" {
  description = "CIDR Subnet Publica C"
  type        = string
  default     = "10.0.3.0/16"
}

variable "app_private_a_subnet_cidr" {
  description = "CIDR Subnet de Aplicação Privada A"
  type        = string
  default     = "10.0.4.0/16"
}
variable "app_private_b_subnet_cidr" {
  description = "CIDR Subnet de Aplicação Privada B"
  type        = string
  default     = "10.0.5.0/16"
}
variable "app_private_c_subnet_cidr" {
  description = "CIDR Subnet de Aplicação Privada C"
  type        = string
  default     = "10.0.6.0/16"
}

variable "data_private_a_subnet_cidr" {
  description = "CIDR Subnet de Banco de Dados A"
  type        = string
  default     = "10.0.7.0/16"
}
variable "data_private_b_subnet_cidr" {
  description = "CIDR Subnet de Banco de Dados B"
  type        = string
  default     = "10.0.8.0/16"
}
variable "data_private_c_subnet_cidr" {
  description = "CIDR Subnet de Banco de Dados C"
  type        = string
  default     = "10.0.9.0/16"
}

variable "database_username" {
  description = "Usuário do Banco de Dados"
  type        = string
  default     = "dbadmin"
}
variable "database_password" {
  description = "Senha para o Banco de Dados"
  type        = string
  default     = "San7anderC0d3r$2024"
}