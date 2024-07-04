data "aws_ecr_repository" "test-app" {
  name = "docker-test"
}



/*resource "aws_ecr_repository" "test-app" {
  name = var.ecr-name
  //force_delete = true
}*/