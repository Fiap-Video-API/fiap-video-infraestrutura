terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-fiap-video-database"
    key            = "terraform/state"
    region         = "us-east-1"
  }
}