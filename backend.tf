terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-unique-fiap-fase5-video"
    key            = "terraform/state"
    region         = "us-east-1"
  }
}
