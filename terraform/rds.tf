# Aurora Serverless v2 (low-cost, autoscaling) in private subnets
resource "aws_db_subnet_group" "main" {
  name       = "${var.project}-${var.environment}"
  subnet_ids = aws_subnet.private[*].id
}

resource "aws_security_group" "rds" {
  name   = "${var.project}-${var.environment}-rds-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }
}

resource "aws_rds_cluster" "main" {
  cluster_identifier          = "${var.project}-${var.environment}"
  engine                      = "aurora-postgresql"
  engine_version              = "15.4"
  master_username             = var.db_username
  manage_master_user_password = true
  db_subnet_group_name        = aws_db_subnet_group.main.name
  vpc_security_group_ids      = [aws_security_group.rds.id]
  serverlessv2_scaling_configuration {
    min_capacity = tonumber(var.aurora_min_acu)
    max_capacity = tonumber(var.aurora_max_acu)
  }
  backup_retention_period = var.environment == "prod" ? 7 : 1
  deletion_protection     = var.environment == "prod" ? true : false
  skip_final_snapshot     = var.environment == "prod" ? false : true
}

resource "aws_rds_cluster_instance" "main" {
  cluster_identifier  = aws_rds_cluster.main.id
  instance_class      = "db.serverless"
  engine              = aws_rds_cluster.main.engine
  engine_version      = aws_rds_cluster.main.engine_version
  publicly_accessible = false
}
