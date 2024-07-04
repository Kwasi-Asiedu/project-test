resource "aws_ecs_cluster" "test-cluster" {
  name = var.test-cluster-name

  depends_on = [var.ecr-repo]
}


resource "aws_ecs_task_definition" "test-task" {
  family                   = var.task-family
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.task-name}",
      "image": "${var.ecr-repo-url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${var.container-port},
          "hostPort": ${var.container-port}
        }
      ],
      "memory": ${var.fargate-memory},
      "cpu": ${var.fargate-cpu}
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = var.fargate-memory
  cpu                      = var.fargate-cpu
  //memory                   = var.fargate-memory
  //cpu                      = var.fargate-cpu
  execution_role_arn = var.ecs_task_execution_role
}






resource "aws_security_group" "ECS-Service-SG" {
  vpc_id      = var.ecs-vpc-id #passed as variable from vpc(output)
  description = "Allows traffic only from load balancer"

  dynamic "ingress" {
    for_each = var.ecs-service-sg-ingress

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      #cidr_blocks = [ aws_vpc.DT-VPC.cidr_block ]
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = var.ecs-lb
    }
  }

  dynamic "egress" {
    for_each = var.ecs-service-sg-egress

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
    Name = "${var.project-name}-ECS-SG"
  }
}


resource "aws_ecs_service" "test-app-service" {
  name            = var.test-app-service-name
  cluster         = aws_ecs_cluster.test-cluster.id
  task_definition = aws_ecs_task_definition.test-task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    target_group_arn = var.lb-target-group
    container_name   = var.task-name
    container_port   = var.container-port
  }

  network_configuration {
    subnets          = [var.ecs-priv-subs[0].id, var.ecs-priv-subs[1].id]
    assign_public_ip = true
    security_groups  = [aws_security_group.ECS-Service-SG.id]
  }
}
