#Security group
resource "aws_security_group" "database-SG" {
  vpc_id = var.DT-VPC

  dynamic "ingress" {
    for_each = var.database_security_group_ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"
    }
  }

  dynamic "egress" {
    for_each = var.database_security_group_egress
    content {
      description = egress.value.description
      from_port   = egress.value.port
      to_port     = egress.value.port
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "-1"
    }
  }

  depends_on = [var.alb_SG]

  tags = {
    Name = "${var.project-name}-Database-SG"
  }
}


# Subnet group
resource "aws_db_subnet_group" "test_subnetgrp" {
  name       = var.db_subnet_group_name
  subnet_ids = [var.priv_subs[0].id, var.priv_subs[1].id]

  tags = {
    Name = "${var.project-name}-db_subnet_group"
  }
}


resource "aws_db_parameter_group" "test-pg-name" {
  name   = "test-pg"
  family = "postgres16"

  parameter {
    name  = "log_connections"
    value = true
  }
}

data "aws_availability_zones" "avail" {

}
#DB instance
resource "aws_db_instance" "default" {
  allocated_storage = var.allocated_storage
  identifier        = var.identifier
  db_name           = var.db_name
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  username          = var.username
  password          = var.password
  //parameter_group_name   = var.parameter_group_name
  parameter_group_name         = aws_db_parameter_group.test-pg-name.name
  skip_final_snapshot          = var.skip_final_snapshot
  db_subnet_group_name         = aws_db_subnet_group.test_subnetgrp.name
  vpc_security_group_ids       = [aws_security_group.database-SG.id]
  storage_encrypted            = var.storage_encrypted
  performance_insights_enabled = var.performance_insights_enabled
  availability_zone            = element(data.aws_availability_zones.avail.names, 1)



  depends_on = [var.DT-VPC]

  tags = {
    Name = "${var.project-name}-DB"
  }
}