terraform {
  required_version = "1.1.3"


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""

}

resource "aws_instance" "ubuntu" {
  ami                         = "ami-04505e74c0741db8d"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.ec2_key.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = ["${aws_security_group.ssh_public.id}", "${aws_security_group.icmp.id}"]
  private_ip                  = "192.168.0.21"
  associate_public_ip_address = true
  tags = {
    Name = "gerencia"

  }

}


resource "aws_instance" "ubuntu2" {
  ami                         = "ami-04505e74c0741db8d"
  instance_type               = "t3.micro"
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = ["${aws_security_group.ssh_private.id}", "${aws_security_group.http.id}", "${aws_security_group.icmp.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "http_server"
  }
}

resource "aws_instance" "ubuntu3" {
  ami                         = "ami-04505e74c0741db8d"
  instance_type               = "t3.micro"
  subnet_id                   = module.vpc.private_subnets[0]
  vpc_security_group_ids      = ["${aws_security_group.ssh_private.id}", "${aws_security_group.http.id}", "${aws_security_group.icmp.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "mysql_server"
  }
}

