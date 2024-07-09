region = "us-west-1"

vpc_cidr             = "10.0.0.0/16"
enable_dns_hostnames = true
project-name         = "test"
tags = {
  Name : "Mac-VPC"
  Env : "test"
}
cloudwatch-tags = {
  Name : "test-log-group"
  Environment : "test"
}
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
pub_subs             = ["public_subnet_1", "public_subnet_2"]
priv_subs            = ["private_subnet_1", "private_subnet_2"]
instance_tenancy     = "default"

alb-security-group-ingress = [{
  description = "Allows HTTP"
  port        = 80
  },
  {
    description = "Allows HTTPS"
    port        = 443
  }, /*{
    description = "Jenkins port"
    port        = 8080
    }, {
    description = "PostgreSQL port"
    port        = 5432
  }*/
]
alb-security-group-egress = [{
  description = "Outbound traffic"
  port        = 0
}]

ecs_task_execution_role = "test-role"

db_subnet_group_name         = "test-db-subnet-group"
identifier                   = "test"
db_name                      = "testDB"
engine                       = "postgres"
engine_version               = "16"
instance_class               = "db.t3.micro"
allocated_storage            = 20
parameter_group_name         = "postgres16"
skip_final_snapshot          = true
storage_encrypted            = true
performance_insights_enabled = true
username                     = "crazywayss"
password                     = "dontprovokeme"
database_security_group_ingress = [{
  description = "Allow SSH"
  port        = 22
  },
  {
    description = "Allow HTTP"
    port        = 80
  },
  {
    description = "PostgreSQL port"
    port        = 5432
}]
database_security_group_egress = [{
  description = "outbound traffic outlet"
  port        = 0
}]

bucket_name = "ebuzu-bucket"
table_name  = "test-table"

//ecr-name = "test-repo"

test-cluster-name     = "test-cluster"
test-app-service-name = "test-service"
task-family           = "test-family"
task-name             = "test-container"
container-port        = 80
//host-port             = 70
ecs-service-sg-ingress = [{
  description = "Allows HTTP"
  port        = 80
  },
  {
    description = "Allows HTTPS"
    port        = 443
  }
]
ecs-service-sg-egress = [{
  description = "Outbound traffic"
  port        = 0
}]

log-stream-name = "test-log-stream"
fargate-cpu     = 256
fargate-memory  = 512

ecs_region = "us-west-1"
ecs_prefix = "ecs"