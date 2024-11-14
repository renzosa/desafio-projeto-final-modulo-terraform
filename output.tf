output "db_password" {
  value       = random_password.db_password.result
  description = "Valor da senha do Banco de Dados"
  sensitive = true
}

output "password_cluster" {
  value = aws_rds_cluster.rds-database-cluster.master_password
  description = "Valor da senha do Banco de Dados"
  sensitive = true
}