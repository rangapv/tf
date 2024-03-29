#create ec2 instance

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
  required_version = ">= 1.2.0"
}


provider "aws" {
  region = var.region 
  access_key = var.accesskey 
  secret_key = var.secretkey 
}

resource "aws_instance" "rayapp_server" {
  ami           = var.ami 
  instance_type = var.ins_type 
  associate_public_ip_address = "true"
  #cpu_core_count = var.cpu_core
  key_name = var.key_name
  #security_groups = [ var.sec_name, ]
  user_data = "${file("./user1.sh")}"
  #volume_size = var.vol_size
  vpc_security_group_ids = [ var.vpcid, ]
  subnet_id = var.subid
  root_block_device {
    volume_size = var.vol_size
  }
  tags = {
    Name = "RayappServerInstance2"
  }
}


output "instances" {
  value       = "${aws_instance.rayapp_server.*.public_ip}"
  description = "PrivateIP address details"
}

