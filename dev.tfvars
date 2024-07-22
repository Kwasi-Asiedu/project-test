region = "eu-west-2"

vpc_cidr             = "120.0.0.0/16"
enable_dns_hostnames = true
project-name         = "dev"
tags = {
  Name : "Mac-VPC"
  Env : "dev"
}
cloudwatch-tags = {
  Name : "dev-log-group"
  Environment : "dev"
}
public_subnet_cidrs  = ["120.0.1.0/24", "120.0.2.0/24"]
private_subnet_cidrs = ["120.0.3.0/24", "120.0.4.0/24"]
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

ecs_task_execution_role = "dev-role"

db_subnet_group_name         = "dev-db-subnet-group"
identifier                   = "dev"
db_name                      = "devDB"
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
table_name  = "dev-table"

//ecr-name = "test-repo"

test-cluster-name     = "dev-cluster"
test-app-service-name = "dev-service"
task-family           = "dev-family"
task-name             = "dev-container"
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

log-stream-name = "dev-log-stream"
fargate-cpu     = 256
fargate-memory  = 512

ecs_region = "eu-west-2"
ecs_prefix = "ecs"