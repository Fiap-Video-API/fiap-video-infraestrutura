resource "aws_db_instance" "db_instance" {
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = "videos"
  username             = "root"
  password             = "fiaproot"
  parameter_group_name = var.parameter_group
  publicly_accessible  = true
  skip_final_snapshot  = true
  apply_immediately    = true

  # Configuração de segurança
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name

}

# Security Group para o banco de dados (controla o tráfego de rede)
resource "aws_security_group" "rds_sg" {
  name        = "rds_security_group"
  description = "Security group para o RDS e DocumentDB"
  vpc_id      = module.vpc_rds.vpc_id
  ingress {
    from_port   = 3306 # Porta MySQL (RDS)
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Defina um IP específico para acesso controlado
  }
  ingress {
    from_port   = 27017 # Porta MongoDB (DocumentDB)
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Todos os protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Virtual Private Cloud - Rede virtual AWS
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc_rds" {

  source = "terraform-aws-modules/vpc/aws" 
  name = "vpc-databases" 
  cidr = "10.0.0.0/16" 
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

   public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "database_subnet_az1" {
  vpc_id            = module.vpc_rds.vpc_id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "food_database_subnet_az_1"
  }
}

resource "aws_subnet" "database_subnet_az2" {
  vpc_id            = module.vpc_rds.vpc_id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "food_database_subnet_az_2"
  }
}

#Subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids =  module.vpc_rds.public_subnets
  tags = {
    Name = "db_subnet_group"
  }
}