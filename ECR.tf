provider "aws" {
  region = var.region
}

resource "aws_ecr_repository" "flask-app" {
    name = var.name
    image_tag_mutability = var.image_tag_mutability
    
    image_scanning_configuration {
      scan_on_push = true
    }
  
}