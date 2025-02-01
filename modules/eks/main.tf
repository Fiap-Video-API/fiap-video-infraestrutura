module "k8s" {
  source = "./infra"

  cluster_name = "fiap-video-k8s"
  region       = "us-east-1"
  zone_az1     = "us-east-1a"
  zone_az2     = "us-east-1b"
  iam_role_arn = "arn:aws:iam::529088294230:user/fiap-video"
  url_load_balance_usuario = "https://fiap-loadbalancer-clientes-1dd22f724063bd6d.elb.us-east-1.amazonaws.com/"
  url_load_balance_video = "https://fiap-loadbalancer-videos-4e9f545fbac71602.elb.us-east-1.amazonaws.com/"
}