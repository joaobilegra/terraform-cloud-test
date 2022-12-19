
module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = "MY-VPC"
  cidr               = "192.168.0.0/24"
  azs                = ["us-east-1a"]
  private_subnets    = ["192.168.0.0/28"]
  public_subnets     = ["192.168.0.16/28"]
  enable_nat_gateway = true


}