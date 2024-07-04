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

variable "project-name" {
  type = string

}

variable "alb_SG" {
  type = any
}

variable "db_subnet_group_name" {
  type = string
}

variable "priv_subs" {
  type = list(any)
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
    condition     = length(var.password) >= 8
    error_message = "Characters should be more than 7"
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

variable "DT-VPC" {
  type = string
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