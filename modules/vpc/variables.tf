variable "vpc_cidr" {
  type = string
  //default = "10.0.0.0/16"

}

variable "enable_dns_hostnames" {
  type = bool
}

variable "tags" {
  type = map(any)
  default = {
    Name : "Mac-VPC"
    Project : "test"
  }
}

variable "project-name" {
  type    = string
  default = "test"

}

variable "instance_tenancy" {
  type = string
  //default = "default"
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