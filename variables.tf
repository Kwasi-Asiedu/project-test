# •••••Region•••••
variable "region" {
  type = string
}


variable "tags" {
  type = map(any)
  /*default = {
    Name : "Mac-VPC"
    Project : "test"
  }*/
}

variable "cloudwatch-tags" {
  type = map(any)
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "instance_tenancy" {
  type = string
  //default = "default"
}

variable "vpc_cidr" {
  type = string
  //default = "10.0.0.0/16"

}


variable "project-name" {
  type = string
  //default = "test"

}


variable "pub_subs" {
  type = list(string)
  //default = [ "public_subnet_1", "public_subnet_2" ]
}

variable "priv_subs" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}


variable "private_subnet_cidrs" {
  type = list(string)
}

variable "alb-security-group-ingress" {
  type = list(object({
    description = string
    port        = number
  }))
  /*default = [ {
    description = "Allows HTTP"
    port = 80
  },
  {
      description = "Allows HTTPS"
      port = 443
    }
   ]*/
}


variable "alb-security-group-egress" {
  type = list(object({
    description = string
    port        = number
  }))
  /*default = [ {
    description = "Outbound traffic"
    port = 0
  } ]*/
}

variable "ecs_task_execution_role" {
  type = string
}

variable "db_subnet_group_name" {
  type = string
}


variable "db_name" {
  type = string
  //default = "cloudrockDB"
}

variable "engine" {
  type = string
  //default = "mysql"
}

variable "engine_version" {
  type = string
  //default = "8.0.35"
}

variable "instance_class" {
  type = string
  //default = "db.t2.micro"
}

variable "username" {
  type      = string
  sensitive = true
  validation {
    condition     = length(var.username) > 4
    error_message = "Username should be longer than 4 characters"
  }
  //default = "admin"
}

variable "password" {
  type      = string
  sensitive = true
  validation {
    condition     = length(var.password) > 8
    error_message = "Characters should be more than 8"
  }
  //default = "alphabeta"
}

variable "allocated_storage" {
  type = number
  //default = 10
}

variable "parameter_group_name" {
  type = string
  //default = "default.mysql8.0"
}

variable "skip_final_snapshot" {
  type = bool
  //default = true
}

variable "database_security_group_ingress" {
  type = list(object({
    description = string
    port        = number
  }))
  /*default = [{
    description = "Allow SSH"
    port        = 22
    },
    {
      description = "Allow HTTP"
      port        = 80
    },
    {
      description = "MySQL port"
      port        = 3306
  }]*/
}

variable "database_security_group_egress" {
  type = list(object({
    description = string
    port        = number
  }))
  /*default = [{
    description = "outbound traffic outlet"
    port        = 0
  }]*/
}

variable "identifier" {
  type = string
}

variable "storage_encrypted" {
  type = bool
}

variable "performance_insights_enabled" {
  type = bool
}

variable "bucket_name" {
  description = "Remote S3 Bucket Name"
  type        = string
  validation {
    condition     = can(regex("^([a-z0-9]{1}[a-z0-9-]{1,61}[a-z0-9]{1})$", var.bucket_name))
    error_message = "Bucket Name must not be empty and must follow S3 naming rules."
  }
}

variable "table_name" {
  description = "Remote DynamoDB Table Name"
  type        = string
}

/*variable "ecr-name" {
  type = string
}*/

variable "test-cluster-name" {
  type = string
}

/*variable "ecs-vpc-id" {
  type = string
}

variable "ecs-subnets" {
  type = list(any)
}*/


variable "task-family" {
  type = string
}

variable "task-name" {
  type = string
}

/*variable "ecr-repo-url" {
  type = string
}*/

variable "container-port" {
  type = number
}

/*variable "host-port" {
  type = number
}*/

/*variable "ecs_task_execution_role" {
  type = any
}*/

/*variable "aws_iam_role_policy_attachment" {
  type = any
}

variable "aws_iam_policy_document" {
  type = any
}*/

variable "test-app-service-name" {
  type = string
}

variable "ecs-service-sg-ingress" {
  type = list(object({
    description = string
    port        = number
  }))

}

variable "ecs-service-sg-egress" {
  type = list(object({
    description = string
    port        = number
  }))

}

variable "log-stream-name" {
  type = string
}

variable "fargate-cpu" {
  type = number
}

variable "fargate-memory" {
  type = number
}

variable "ecs_region" {
  type = string
}

variable "ecs_prefix" {
  type = string
}