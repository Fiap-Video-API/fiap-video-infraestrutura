terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-unique-fiap-video-database"
    key            = "terraform/state"
    region         = "us-east-1"
  }
}