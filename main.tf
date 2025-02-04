module "k8s" {
  source = "./infra"

  cluster_name = "fiap-video-k8s"
  region       = "us-east-1"
  zone_az1     = "us-east-1a"
  zone_az2     = "us-east-1b"
  iam_role_arn = "arn:aws:iam::756624658310:role/LabRole"
}
