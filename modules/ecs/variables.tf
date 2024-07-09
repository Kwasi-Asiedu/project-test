variable "test-cluster-name" {
  type = string
}

variable "ecs-vpc-id" {
  type = string
}

/*variable "ecs-subnets" {
  type = list(any)
}*/

variable "task-family" {
  type = string
}

variable "task-name" {
  type = string
}

variable "ecr-repo-url" {
  type = string
}

variable "container-port" {
  type = number
}

/*variable "host-port" {
  type = number
}*/

variable "ecs_task_execution_role" {
  type = any
}

variable "aws_iam_role_policy_attachment" {
  type = any
}

variable "aws_iam_policy_document" {
  type = any
}

variable "test-app-service-name" {
  type = string
}

variable "lb-target-group" {
  type = any
}

variable "ecs-priv-subs" {
  type = list(any)
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

variable "ecs-lb" {
  type = any
}

variable "project-name" {
  type = string
}

variable "fargate-cpu" {
  type = number
}

variable "fargate-memory" {
  type = number
}

variable "ecr-repo" {
  type = any
}

variable "log_group_name" {
  type = string
}
variable "ecs_region" {
  type = string
}

variable "ecs_prefix" {
  type = string
}