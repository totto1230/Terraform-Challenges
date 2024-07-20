terraform {
  required_providers {
    aws = {
       version = "~> 2.54"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = "AKIA4MTWHVKZBKUPDGN5"
  secret_key = "E2RCuDoIow/OSqbXqdDUqbjFW212vH3V0AwY61DO"
}

variable "splunk" {
  default = "8088"
}

resource "aws_eip" "example" {
  vpc = "true"
}

variable "sg_port_dev" {
  type = list(number)
  description = "SG Dev Ports"
  default = [ 443, 8080 ]

}

resource "aws_security_group" "security_group_payment_app" {
  name        = "payment_app"
  description = "Application Security Group"
  depends_on  = [aws_eip.example]
   
    # Below ingress allows APIs access from DEV VPC and  # Below ingress allows HTTPS  from DEV VPC
    dynamic "ingress"{
      for_each = var.sg_port_dev
      content {
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = ["172.31.0.0/16"]
      }
    }

  # Below ingress allows APIs access from Prod App Public IP.

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.example.public_ip}/32"]
  }

  egress {
  from_port   = var.splunk
  to_port     = var.splunk
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"] 
  }

}
