resource "aws_ecr_repository" "app_3soat_repository" {
  name                 = "app-repository"
  image_tag_mutability = "MUTABLE"
}