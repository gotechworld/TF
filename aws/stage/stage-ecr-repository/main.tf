###################################################
# ECR repo for sf-flex-identity-manager
###################################################
resource "aws_ecr_repository" "ecr_sf-flex-identity-manager" {
  name                 = "sf-flex-identity-manager"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "Stage",
    app = "sf-flex-identity-manager"
  }

}

###################################################
# ECR repo for sf-flex-price-promo-api
###################################################
resource "aws_ecr_repository" "ecr_sf-flex-price-promo-api" {
  name                 = "sf-flex-price-promo-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "Stage",
    app = "sf-flex-price-promo-api"
  }

}

###################################################
# ECR repo for sf-flex-oms
###################################################
resource "aws_ecr_repository" "ecr_sf-flex-oms" {
  name                 = "sf-flex-oms"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "Stage",
    app = "sf-flex-oms"
  }

}

###################################################
# ECR repo for sf-flex-checkout
###################################################
resource "aws_ecr_repository" "ecr_sf-flex-checkout" {
  name                 = "sf-flex-checkout"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "Stage",
    app = "sf-flex-checkout"
  }

}

###################################################
# ECR repo for sf-flex-stock
###################################################
resource "aws_ecr_repository" "ecr_sf-flex-stock" {
  name                 = "sf-flex-stock"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "Stage",
    app = "sf-flex-stock"
  }

}

###################################################
# ECR repo for sf-flex-customer-support
###################################################
resource "aws_ecr_repository" "ecr_sf-flex-customer-support" {
  name                 = "sf-flex-customer-support"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "Stage",
    app = "sf-flex-customer-support"
  }

}

###################################################
# ECR repo for sf-flex-customer-management
###################################################
resource "aws_ecr_repository" "ecr_sf-flex-customer-management" {
  name                 = "sf-flex-customer-management"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "Stage",
    app = "sf-flex-customer-management"
  }

}

###################################################
# ECR repo for sf-flex-payment
###################################################
resource "aws_ecr_repository" "ecr_sf-flex-payment" {
  name                 = "sf-flex-payment"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "Stage",
    app = "sf-flex-payment"
  }

}


###################################################
# ECR repo for sf-flex-global-config-api
###################################################
resource "aws_ecr_repository" "ecr_sf-flex-global-config-api" {
  name                 = "sf-flex-global-config-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "Stage",
    app = "sf-flex-global-config-api"
  }

}

###################################################
# ECR repo for sf-flex-notifications
###################################################
resource "aws_ecr_repository" "ecr_sf-flex-notifications" {
  name                 = "sf-flex-notifications"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "Stage",
    app = "sf-flex-notifications"
  }

}

###################################################
# ECR repo for sf-flex-rrad
###################################################
resource "aws_ecr_repository" "ecr_sf-flex-rrad" {
  name                 = "sf-flex-rrad"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "Stage",
    app = "sf-flex-rrad"
  }

}

###################################################
# ECR repo for sf3-api-magento
###################################################
resource "aws_ecr_repository" "ecr_sf3-api-magento" {
  name                 = "sf3-api-magento"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    env = "Stage",
    app = "sf3-api-magento"
  }

}
