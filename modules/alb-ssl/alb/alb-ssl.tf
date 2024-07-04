resource "aws_security_group" "DT-ALB-SG" {
  vpc_id = var.test-vpc-id #passed as variable from vpc(output)

  dynamic "ingress" {
    for_each = var.alb-security-group-ingress

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      #cidr_blocks = [ aws_vpc.DT-VPC.cidr_block ]
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.alb-security-group-egress

    content {
      description = egress.value.description
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = "-1"
      #cidr_blocks = [ aws_vpc.DT-VPC.cidr_block ]
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "${var.project-name}-ALB-SG"
  }
}




resource "aws_alb" "DT-alb" {
  name            = "Alpha-ALB"
  subnets         = [var.pub_subs[0].id, var.pub_subs[1].id]
  security_groups = [aws_security_group.DT-ALB-SG.id]
}


# Target group 
resource "aws_lb_target_group" "DT-TG" {
  name        = "Alpha-TG"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.test-vpc-id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = "/"
    interval            = 5
  }
}


# Listener(s)
resource "aws_lb_listener" "DT-listener" {
  load_balancer_arn = aws_alb.DT-alb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

}

resource "aws_lb_listener" "DT-listener-2" {
  load_balancer_arn = aws_alb.DT-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.acm_certificate
  //certificate_arn   = "arn:aws:acm:eu-west-2:565581625100:certificate/778a277c-2bc9-4b81-84b1-b46144643e80"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.DT-TG.arn
  }

}
