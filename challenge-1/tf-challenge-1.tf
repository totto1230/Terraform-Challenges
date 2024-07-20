terraform {
    
    required_providers {
        digitalocean = {
            source = "digitalocean/digitalocean"
        }

        aws = {
            version = "~> 2.54"
        }

    }

    required_version = "1.8.5"
}

  provider "aws" {
    region = "us-east-1"
    access_key = "AKIA4MTWHVKZBKUPDGN5"
    secret_key = "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"
}

provider "digitalocean" {}

resource "aws_eip" "kplabs_app_ip" {
    vpc = true
}
