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

variable "project-name" {
  type = string
  //default = "test"

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

variable "test-vpc-id" {
  type = string
}

variable "pub_subs" {
  type = list(any)
}

variable "acm_certificate" {
  type = any
}

/*variable "alb_cidr" {
  type = string
}*/