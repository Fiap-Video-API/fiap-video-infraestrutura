provider "aws" {
  region = var.aws_region
}

module "eks" {
  source = "./modules/eks"
}
