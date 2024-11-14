variable "main_vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "main_vpc_name" {
  description = "Nome da VPC"
  type        = string
  default     = "tf-main-vpc"
}

variable "number_of_zones" {
  description = "Número de instâncias"
  type        = number
  default     = 3
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "availability_zones_names" {
  description = "Availability Zones Names"
  type        = list(string)
  default     = ["a", "b", "c"]
}

variable "public_subnet_cidrs" {
  description = "CIDR Subnets Publicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "CIDR Subnets Privadas de Aplicação"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "private_data_subnet_cidrs" {
  description = "CIDR Subnets Privadas de Dados"
  type        = list(string)
  default     = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
}

variable "buckets_name" {
  description = "Nome base dos Buckets"
  type        = string
  default     = "tf-bucket-renzo-santander-coders-2024-by-ada-for"
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
