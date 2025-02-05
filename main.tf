provider "aws" {
  region = var.aws_region
}

module "cognito" {
  source = "./modules/cognito"
}

module "database" {
  source = "./modules/database"
}

module "eks" {
  source = "./modules/eks"
}

module "ses" {
  source = "./modules/ses"
}

module "sqs" {
  source = "./modules/sqs"
}
