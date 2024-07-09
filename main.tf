/*terraform {


  backend "s3" {
    bucket         = "ebuzu-bucket"
    key            = "key/terraform.tfstate"
    encrypt        = true
    region         = "eu-west-2"
    dynamodb_table = "test-table"

  }

  
}*/


module "Test-VPC" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  priv_subs            = var.priv_subs
  pub_subs             = var.pub_subs
  tags                 = var.tags
  instance_tenancy     = var.instance_tenancy
}


module "Test-ALB" {
  source                     = "./modules/alb-ssl/alb"
  test-vpc-id                = module.Test-VPC.vpc_id
  alb-security-group-egress  = var.alb-security-group-egress
  alb-security-group-ingress = var.alb-security-group-ingress
  pub_subs                   = module.Test-VPC.public_subnets
  project-name               = var.project-name
  acm_certificate            = module.Test-acm_certificate.acm_certificate
}


module "Test-role" {
  source                  = "./modules/iamrole"
  ecs_task_execution_role = var.ecs_task_execution_role
}

module "RDS" {
  source                          = "./modules/rds"
  allocated_storage               = var.allocated_storage
  db_name                         = var.db_name
  identifier                      = var.identifier
  engine                          = var.engine
  engine_version                  = var.engine_version
  instance_class                  = var.instance_class
  username                        = var.username
  password                        = var.password
  db_subnet_group_name            = var.db_subnet_group_name
  skip_final_snapshot             = var.skip_final_snapshot
  parameter_group_name            = var.parameter_group_name
  priv_subs                       = module.Test-VPC.private_subnets
  storage_encrypted               = var.storage_encrypted
  performance_insights_enabled    = var.performance_insights_enabled
  alb_SG                          = module.Test-ALB.alb_sg_id
  DT-VPC                          = module.Test-VPC.vpc_id
  database_security_group_ingress = var.database_security_group_ingress
  database_security_group_egress  = var.database_security_group_egress
  project-name                    = var.project-name
}


/*module "S3" {
  source      = "./modules/backend"
  bucket_name = var.bucket_name
  table_name  = var.table_name
}*/


module "Test-ecr" {
  source = "./modules/ecr"
  #ecr-name = var.ecr-name
}


module "Test-ECS" {
  source            = "./modules/ecs"
  test-cluster-name = var.test-cluster-name
  ecs-vpc-id        = module.Test-VPC.vpc_id
  //ecs-subnets = module.Test-VPC.private_subnets
  ecr-repo-url = module.Test-ecr.ecr-repo-url
  task-family  = var.task-family
  task-name    = var.task-name
  //host-port                      = var.host-port
  container-port                 = var.container-port
  ecs_task_execution_role        = module.Test-role.ecs_task_execution_role
  aws_iam_role_policy_attachment = module.Test-role.ecs_iam_role_policy_attachment
  aws_iam_policy_document        = module.Test-role.iam_policy_document
  lb-target-group                = module.Test-ALB.target-group
  test-app-service-name          = var.test-app-service-name
  ecs-lb                         = module.Test-ALB.alb_sg_id
  ecs-priv-subs                  = module.Test-VPC.private_subnets
  ecs-service-sg-ingress         = var.ecs-service-sg-ingress
  ecs-service-sg-egress          = var.ecs-service-sg-egress
  project-name                   = var.project-name
  fargate-cpu                    = var.fargate-cpu
  fargate-memory                 = var.fargate-memory
  ecr-repo                       = module.Test-ecr.ecr-repo
  ecs_prefix = var.ecs_prefix
  ecs_region = var.ecs_region
  log_group_name = module.Test-cloudwatch.log_group_name
}


module "Test-cloudwatch" {
  source          = "./modules/cloudwatch"
  log-stream-name = var.log-stream-name
  cloudwatch-tags = var.cloudwatch-tags
}

module "Test-route53" {
  source              = "./modules/route53"
  route-53-lb-zone-id = module.Test-ALB.lb-zone-id
  route53-lb-dns-name = module.Test-ALB.load_balancer_dns_name
  //r53_acm_validation_record = module.Test-acm_certificate.acm_certificate
}

module "Test-acm_certificate" {
  source = "./modules/acm"
}
