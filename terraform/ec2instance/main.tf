# Provider - export AWS_accesskey and secret key. region frow aws region
terraform {
  backend "s3" {
    bucket = "satyam-s3-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

# security group: vpc_id is given in aws instance
resource "aws_security_group" "satyam_security_group" {
  name        = "satyam_security_group"
  description = "Satyam security group"
  vpc_id      = "vpc-019c09a1a0c5b4f6b"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "http req"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "satyam_security_group"
  }
}

# subnet cidr_block
resource "aws_subnet" "satyam-subnet" {
  vpc_id     = "vpc-019c09a1a0c5b4f6b"
  cidr_block = "10.0.0.64/28"
  tags       = {
    "Name" : "Satyam subnet"
  }
}

# aws key pair- create key pair in aws and write key name here
data "aws_key_pair" "satyam-gurukul-sey" {
  key_name           = "satyam123"
  include_public_key = true
}


resource "aws_instance" "esop-satyam" {
  ami                         = "ami-00c39f71452c08778"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.satyam-subnet.id
  associate_public_ip_address = true
  key_name                    = data.aws_key_pair.satyam-gurukul-sey.key_name
  vpc_security_group_ids      = [aws_security_group.satyam_security_group.id]
  tags                        = {
    Name = "satyam-gurukul"
  }
}
