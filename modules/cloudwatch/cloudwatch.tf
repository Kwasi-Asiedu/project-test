resource "aws_cloudwatch_log_group" "test-log-group" {
  name              = "ecs/test-container"
  retention_in_days = 30

  tags = var.cloudwatch-tags
}

resource "aws_cloudwatch_log_stream" "test-log-stream" {
  name           = var.log-stream-name
  log_group_name = aws_cloudwatch_log_group.test-log-group.name
}