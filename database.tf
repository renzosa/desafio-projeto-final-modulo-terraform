# DB SUBNET GROUP
resource "aws_db_subnet_group" "rds-subnet-group" {
  name       = "rds-subnet-group"
  subnet_ids = aws_subnet.private_data[*].id

  tags = {
    Name = "rds-subnet-group"
  }
}

# DB INSTANCE 
resource "aws_rds_cluster" "rds-database-cluster" {
  db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.name

  cluster_identifier = "tf-db-cluster-mysql"
  availability_zones = var.availability_zones

  engine                   = "mysql"
  engine_version           = "8.0.39"
  engine_lifecycle_support = "open-source-rds-extended-support-disabled"

  db_cluster_instance_class = "db.c6gd.medium"
  storage_type              = "gp3"
  allocated_storage         = 50

  database_name   = "myApp"
  master_username = var.database_username
  master_password = var.database_password

  skip_final_snapshot = true

  vpc_security_group_ids = [aws_security_group.db_sg.id]
  depends_on             = [aws_db_subnet_group.rds-subnet-group]

  tags = {
    Name = "rds-database-cluster"
  }
}
