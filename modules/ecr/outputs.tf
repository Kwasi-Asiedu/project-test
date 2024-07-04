output "ecr-repo-url" {
  value = data.aws_ecr_repository.test-app.repository_url
}

output "ecr-repo" {
  value = data.aws_ecr_repository.test-app.arn
}