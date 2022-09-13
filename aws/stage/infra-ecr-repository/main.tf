###################################################
# ECR repo for composer-php
###################################################
resource "aws_ecr_repository" "ecr_composer-php" {
  name                 = "composer-php"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env  = "Infra",
    role = "Common"
    app  = "composer-php"
  }

}

###################################################
# ECR repo for php
###################################################
resource "aws_ecr_repository" "ecr_php" {
  name                 = "php"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env  = "Infra",
    role = "Common"
    app  = "php"
  }

}

###################################################
# ECR repo for php
###################################################
resource "aws_ecr_repository" "ecr_php" {
  name                 = "php"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env  = "Infra",
    role = "Common"
    app  = "php"
  }

}